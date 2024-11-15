using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
    public class TopProductosModel : PageModel
    {
        private readonly string _connectionString;
        public List<(string Nombre, string Descripcion, int Cantidad)> TopProductos { get; set; } = new List<(string, string, int)>();

        [BindProperty(SupportsGet = true)]
        public string FechaInicio { get; set; }

        [BindProperty(SupportsGet = true)]
        public string FechaFin { get; set; }

        public TopProductosModel(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            TopProductos = await GetTopProductosAsync(FechaInicio, FechaFin);
            return Page();
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna ala lista top
          /// </summary>
          /// <returns></returns>
        private async Task<List<(string, string, int)>> GetTopProductosAsync(string fechaInicio, string fechaFin)
        {
            var productos = new List<(string, string, int)>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                var query = "SELECT nombre, descripcion, cantidad FROM dbo.top10(@fecha_inicio, @fecha_fin)";
                using (var command = new SqlCommand(query, conexion))
                {
                    command.Parameters.AddWithValue("@fecha_inicio", string.IsNullOrEmpty(fechaInicio) ? (object)DBNull.Value : fechaInicio);
                    command.Parameters.AddWithValue("@fecha_fin", string.IsNullOrEmpty(fechaFin) ? (object)DBNull.Value : fechaFin);

                    await conexion.OpenAsync();
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            var nombre = reader.GetString(0);
                            var descripcion = reader.GetString(1);
                            var cantidad = reader.GetInt32(2);

                            productos.Add((nombre, descripcion, cantidad));
                        }
                    }
                }
            }
            return productos;
        }
    }
}
