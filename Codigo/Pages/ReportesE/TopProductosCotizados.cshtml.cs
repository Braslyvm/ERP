using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
    public class TopProductosModel : PageModel {
        private readonly string _connectionString;
        public List<(string Nombre, string Descripcion, int Cantidad)> TopProductos { get; set; } = new List<(string, string, int)>();

        public TopProductosModel(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync(){
            TopProductos = await GetTopProductosAsync();
            return Page();
        }

        private async Task<List<(string, string, int)>> GetTopProductosAsync(){
            var productos = new List<(string, string, int)>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT nombre, descripcion, cantidad FROM dbo.top10", conexion);
                await conexion.OpenAsync();
                using (var leer = await command.ExecuteReaderAsync()){
                    while (await leer.ReadAsync()){
                        var nombre = leer.GetString(0);  
                        var descripcion = leer.GetString(1);
                        var cantidad = leer.GetInt32(2);  

                        productos.Add((nombre, descripcion, cantidad));
                    }
                }
            }
            return productos;
        }
    }
}
