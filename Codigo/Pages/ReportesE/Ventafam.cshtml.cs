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
    public class Ventafam : PageModel
    {
        private readonly string _connectionString;

        public List<FamiliaProductosData> FamiliaProductosList { get; set; } = new List<FamiliaProductosData>();

        public Ventafam(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM FamiliaProductos", connection))
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            FamiliaProductosList.Add(new FamiliaProductosData
                            {
                                NombreFamilia = reader["nombreFam"].ToString(),
                                TotalMonto = decimal.Parse(reader["total"].ToString())
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class FamiliaProductosData
    {
        public string NombreFamilia { get; set; }
        public decimal TotalMonto { get; set; }
    }
}
