using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    public class COVE : PageModel
    {
        private readonly string _connectionString;

        public List<VentaCotizacionData> Ventas { get; set; } = new List<VentaCotizacionData>();

        public COVE(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task<IActionResult> OnGetAsync()
        {
            string query = "SELECT anio, mes, cantidadcotizacion, cantidadventas FROM dbo.ventasycotizacionesmeas";
            
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Ventas.Add(new VentaCotizacionData
                            {
                                AnioMes = $"{reader["anio"]}-{reader["mes"]}",
                                CantidadCotizaciones = reader["cantidadcotizacion"] != DBNull.Value ? int.Parse(reader["cantidadcotizacion"].ToString()) : 0,
                                CantidadVentas = reader["cantidadventas"] != DBNull.Value ? int.Parse(reader["cantidadventas"].ToString()) : 0
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class VentaCotizacionData
    {
        public string AnioMes { get; set; }
        public int CantidadCotizaciones { get; set; }
        public int CantidadVentas { get; set; }
    }
}
