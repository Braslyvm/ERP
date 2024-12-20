using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    public class mesplantilla : PageModel
    {
        private readonly string _connectionString;

        public mesplantilla(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public List<Dictionary<string, object>> Planillas { get; set; } = new List<Dictionary<string, object>>();

        // Nueva propiedad para el mes seleccionado
        [BindProperty(SupportsGet = true)]
        public string Mes { get; set; }

        public async Task<IActionResult> OnGetAsync(bool? success)
        {
            // Validación básica para el valor del mes
            var mesesPermitidos = new HashSet<string> 
            {
                "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", 
                "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre"
            };

            if (!string.IsNullOrEmpty(Mes) && mesesPermitidos.Contains(Mes))
            {
                Planillas.Clear(); // Limpiamos la lista para evitar acumulaciones
                await LoadPlanillaAsync(Mes);
            }

            return Page();
        }

        private async Task LoadPlanillaAsync(string mes)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (SqlCommand command = new SqlCommand("usuarios.PlanillaMes", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@mes", mes);

                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            var row = new Dictionary<string, object>
                            {
                                ["cedula"] = reader["cedula"],
                                ["nombre_completo"] = reader["nombre_completo"],
                                ["departamento"] = reader["departamento"],
                                ["h_normales"] = reader["h_normales"],
                                ["h_extras"] = reader["h_extras"],
                                ["salario_actual"] = reader["salario_actual"],
                                ["total_salario"] = reader["total_salario"]
                            };
                            Planillas.Add(row);
                        }
                    }
                }
            }
        }
    }
}
