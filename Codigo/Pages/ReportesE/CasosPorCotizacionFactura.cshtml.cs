using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    public class CASOS : PageModel
    {
        private readonly string _connectionString;

        public List<CasosData> Casos { get; set; } = new List<CasosData>();

        public CASOS(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM dbo.casos_cotizacion_factura()", connection))
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Casos.Add(new CasosData
                            {
                                año = reader["año"].ToString(),
                                mes = reader["mes"].ToString(),
                                tipo = reader["tipo"].ToString(),
                                cantidad = int.Parse(reader["cantidad_casos"].ToString()),
                                mesAño = reader["año"].ToString() + "-" + reader["mes"].ToString().PadLeft(2, '0')
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class CasosData
    {
        public string año { get; set; }
        public string mes { get; set; }
        public string tipo { get; set; }
        public int cantidad { get; set; }
        public string mesAño { get; set; }
    }
}
