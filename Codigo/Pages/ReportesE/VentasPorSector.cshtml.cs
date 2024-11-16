using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    /// <summary>
        /// calcaula el total de ventas por sector
        /// </summary>
        public class VentaSector : PageModel
    {
        private readonly string _connectionString;

        public List<VentaSectorData> Ventas { get; set; } = new List<VentaSectorData>();
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }

        public VentaSector(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task<IActionResult> OnGetAsync(DateTime? fecha_inicio, DateTime? fecha_fin)
        {
            FechaInicio = fecha_inicio;
            FechaFin = fecha_fin;

            string query = "SELECT * FROM VentaSector(@fecha_inicio, @fecha_fin)"; // Using the function created

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@fecha_inicio", (object)fecha_inicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@fecha_fin", (object)fecha_fin ?? DBNull.Value);

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

    /// <summary>
        /// clase del tipoo de la tabla
        /// </summary>
        public class VentaSectorData
    {
        public string Sector { get; set; }
        public decimal TotalVenta { get; set; }
    }
}
