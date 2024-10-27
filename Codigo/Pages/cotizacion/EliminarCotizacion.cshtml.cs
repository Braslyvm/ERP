using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;
namespace proyecto1bases.Pages {
  
// Página de modelo para la gestión de planillas
    public class EliminarCotizacion : PageModel{
        public int IdCotizacion { get; set; }
        public List<int> Cotizacion { get; set; }= new List<int>();
         public bool funciono { get; set; } 
        
        private readonly string _connectionString;

        public EliminarCotizacion(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public async Task<IActionResult> OnGetAsync(bool? success){
            Cotizacion = GetCotizacion();
            
            funciono = success ?? false;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(){
            IdCotizacion = int.Parse(Request.Form["IdCotizacion"]);


            await eliminarCotizacion(IdCotizacion);
            return RedirectToPage(new { success = true });
        }
        public List<int> GetCotizacion(){
            var cotizaciones = new List<int>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT id_cotizacion FROM dbo.cotizaciones()", conexion);
                conexion.Open();
                using (var reader = command.ExecuteReader()){
                    while (reader.Read()){
                        var id_cotizacion = reader.GetInt32(0);   
                        cotizaciones.Add(id_cotizacion);
                    }
                }
            }
            return cotizaciones;
        }
        public async Task eliminarCotizacion(int id_cotizacion){
            using (var conexion = new SqlConnection(_connectionString)){
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC cotizaciones.eliminar_cotizacion @id_cotizacion", conexion);
                comando.Parameters.AddWithValue("@id_cotizacion", id_cotizacion);
                await comando.ExecuteNonQueryAsync();
            }
        }

    }
}
