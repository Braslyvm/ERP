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
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }

        public Ventadepartamento(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task<IActionResult> OnGetAsync(string fecha_inicio = null, string fecha_fin = null)
        {
            FechaInicio = fecha_inicio;
            FechaFin = fecha_fin;

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM dbo.Ventadepartamento(@fecha_inicio, @fecha_fin)", connection))
                {
                    command.Parameters.AddWithValue("@fecha_inicio", (object)fecha_inicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@fecha_fin", (object)fecha_fin ?? DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Ventas.Add(new VentadepartamentoData
                            {
                                departamento = reader["departamento_actual"].ToString(),
                                cantidadVentas = int.Parse(reader["cantidad_ventas"].ToString())
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
