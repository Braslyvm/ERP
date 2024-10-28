using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.Generic;

public class inicio_secionModel : PageModel {
    [BindProperty]
    public string Contraseña { get; set; }

    [BindProperty]
    public int Identificacion { get; set; }

    public string MensajeError { get; set; }

    private readonly string _connectionString;

    public inicio_secionModel(IConfiguration configuration) {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    public void OnGet() {
    }

    public async Task<IActionResult> OnPostAsync() {
        if (!ModelState.IsValid) {
            return Page();
        }

        int resultadoValidacion = await ValidarUsuario(Identificacion, Contraseña);

        if (resultadoValidacion == 1) {
            await GuardarCedula(Identificacion); 
            return RedirectToPage("/Menu"); 
        } else {
            ModelState.AddModelError(string.Empty, "Credenciales inválidas. Inténtalo de nuevo.");
            return Page();
        }
    }

    public async Task<int> ValidarUsuario(int identificacion, string contraseña) {
        if (string.IsNullOrEmpty(contraseña)) {
            return 0; 
        }
        using (var conexion = new SqlConnection(_connectionString)) {
            await conexion.OpenAsync();
            using (var comando = new SqlCommand("SELECT dbo.InicioValido(@Cedula, @Contrasena)", conexion)) {
                comando.Parameters.AddWithValue("@Cedula", identificacion);
                comando.Parameters.AddWithValue("@Contrasena", contraseña);

                object result = await comando.ExecuteScalarAsync();
                return (result != null) ? Convert.ToInt32(result) : 0;
            }
        }
    }

    public async Task GuardarCedula(int cedula) {
        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
        var contenidoJson = await System.IO.File.ReadAllTextAsync(filePath);
        var json = JsonSerializer.Deserialize<Dictionary<string, object>>(contenidoJson);
        json.Remove("Cedulas");

        json["Cedulas"] = new List<int> { cedula };
        var nuevojson = JsonSerializer.Serialize(json, new JsonSerializerOptions { WriteIndented = true });
        await System.IO.File.WriteAllTextAsync(filePath, nuevojson);
    }

}
