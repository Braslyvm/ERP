using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    public class Ventazona : PageModel
    {
        private readonly string _connectionString;

        public List<VentazonaData> Ventas { get; set; } = new List<VentazonaData>();

        public Ventazona(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM VentaZona", connection)) // Consulta a la vista
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Ventas.Add(new VentazonaData
                            {
                                zona = reader["zona"].ToString(),
                                TotalVenta = decimal.Parse(reader["total"].ToString())
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class VentazonaData
    {
        public string zona { get; set; }
        public decimal TotalVenta { get; set; }
    }
}
