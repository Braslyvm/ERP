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
    public class MAño : PageModel
    {
        private readonly string _connectionString;

        public List<PlanillaDataAnio> Planilla { get; set; } = new List<PlanillaDataAnio>();
        public int? AnioInicio { get; set; }
        public int? AnioFin { get; set; }

        public MAño(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        /// <summary>
                ///  al iniiciar la pagina se carga la informacion y puede ser filtrada
                /// </summary>
                /// <param name="anioInicio"></param>
                /// <param name="anioFin"></param>
                /// <returns> grafico de barras con informacion de la tabla</returns>
                public async Task<IActionResult> OnGetAsync(int? anioInicio, int? anioFin)
        {
            // Asignar los valores de los filtros a las propiedades
            AnioInicio = anioInicio ?? 2000; // Valor predeterminado de inicio
            AnioFin = anioFin ?? 2024; // Valor predeterminado de fin

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Consulta SQL con parámetros para los años
                var query = "SELECT * FROM usuarios.planillaaños(@anioInicio, @anioFin)";

                using (var command = new SqlCommand(query, connection))
                {
                    // Agregar los parámetros a la consulta
                    command.Parameters.AddWithValue("@anioInicio", AnioInicio);
                    command.Parameters.AddWithValue("@anioFin", AnioFin);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Planilla.Add(new PlanillaDataAnio
                            {
                                Año = reader["año"].ToString(),
                                TotalSalario = decimal.Parse(reader["total_salario"].ToString())
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    // Clase para representar los datos de la planilla por año
    public class PlanillaDataAnio
    {
        public string Año { get; set; }
        public decimal TotalSalario { get; set; }
    }
}
