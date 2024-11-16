using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
    /// <summary>
        /// clase que calcula y muestra las ventas y cotixzaciones mensuales
        /// 
        /// </summary>
        public class COVE : PageModel
    {
        private readonly string _connectionString;

        public List<VentaCotizacionData> Ventas { get; set; } = new List<VentaCotizacionData>();

        [BindProperty(SupportsGet = true)]
        public DateTime? FechaInicio { get; set; }

        [BindProperty(SupportsGet = true)]
        public DateTime? FechaFin { get; set; }

        public COVE(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        /// <summary>
                /// RETORNA LAS COTIZACIONES PPOR MES Y Año
                /// </summary>
                /// <returns>retorna grafico de barras comparatiov</returns>
                public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                string query = "SELECT anio, mes, cantidadcotizacion, cantidadventas " +
                               "FROM dbo.ventasycotizacionesmeasZ(@fecha_inicio, @fecha_fin)";

                using (var command = new SqlCommand(query, connection))
                {
                    // Pasar los parámetros de fechas con manejo de valores nulos.
                    command.Parameters.AddWithValue("@fecha_inicio", (object)FechaInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@fecha_fin", (object)FechaFin ?? DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Ventas.Add(new VentaCotizacionData
                            {
                                AnioMes = $"{reader["anio"]}-{reader["mes"]}",
                                CantidadCotizaciones = reader["cantidadcotizacion"] != DBNull.Value ? Convert.ToInt32(reader["cantidadcotizacion"]) : 0,
                                CantidadVentas = reader["cantidadventas"] != DBNull.Value ? Convert.ToInt32(reader["cantidadventas"]) : 0
                            });
                        }
                    }
                }
            }

            return Page();
        }
    }

    /// <summary>
        /// clase que almacena los datos del tipo de tabla
        /// </summary>
        public class VentaCotizacionData
    {
        public string AnioMes { get; set; }
        public int CantidadCotizaciones { get; set; }
        public int CantidadVentas { get; set; }
    }
}
