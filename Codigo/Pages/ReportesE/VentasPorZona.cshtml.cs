using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
   /// <summary>
      /// clase que calcula las ventas por zona
      /// </summary>
      public class Ventazona : PageModel
    {
        private readonly string _connectionString;

        public List<VentazonaData> Ventas { get; set; } = new List<VentazonaData>();
        public DateTime? FechaInicio { get; set; }  
        public DateTime? FechaFin { get; set; }    

        public Ventazona(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
         
    
         
         
        /// <summary>
                /// calcula la informacion si las fecha sson null retorna todo
                /// </summary>
                /// <param name="fechaInicio"></param>
                /// <param name="fechaFin"></param>
                /// <returns></returns>
                public async Task<IActionResult> OnGetAsync(DateTime? fechaInicio = null, DateTime? fechaFin = null)
        {
            FechaInicio = fechaInicio;
            FechaFin = fechaFin;

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Usamos parámetros para evitar inyecciones SQL
                using (var command = new SqlCommand("SELECT * FROM dbo.VentaZona(@FechaInicio, @FechaFin)", connection))
                {
                    command.Parameters.AddWithValue("@FechaInicio", (object)FechaInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@FechaFin", (object)FechaFin ?? DBNull.Value);

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

/// <summary>
/// clase del tipo de la tabla
/// </summary>
public class VentazonaData
    {
        public string zona { get; set; }
        public decimal TotalVenta { get; set; }
    }
}
