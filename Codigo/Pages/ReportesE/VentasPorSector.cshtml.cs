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
    public class VentaSector : PageModel
    {
        private readonly string _connectionString;

        public List<VentaSectorData> Ventas { get; set; } = new List<VentaSectorData>();

        public VentaSector(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM VentaSector", connection)) // Consulta a la vista
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Ventas.Add(new VentaSectorData
                            {
                                Sector = reader["sector"].ToString(),
                                TotalVenta = decimal.Parse(reader["total"].ToString())
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class VentaSectorData
    {
        public string Sector { get; set; }
        public decimal TotalVenta { get; set; }
    }
}
