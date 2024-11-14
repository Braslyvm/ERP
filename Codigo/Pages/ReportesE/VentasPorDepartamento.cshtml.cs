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
    public class Ventadepartamento : PageModel
    {
        private readonly string _connectionString;

        public List<VentadepartamentoData> Ventas { get; set; } = new List<VentadepartamentoData>();

        public Ventadepartamento(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM Ventadepartamento", connection)) // Consulta a la vista
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Ventas.Add(new VentadepartamentoData
                            {
                                departamento = reader["departamento_actual"].ToString(),
                                cantidadVentas = int.Parse(reader["cantidadVentas"].ToString())
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class VentadepartamentoData
    {
        public string departamento { get; set; }
        public int cantidadVentas { get; set; }
    }
}
