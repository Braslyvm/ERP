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
        
        public MAño(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("usuarios.Planillaanio", connection)) // Llama el procedimiento almacenado
                {
                    command.CommandType = CommandType.StoredProcedure;

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync()) // Lee cada fila de los resultados
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

    // Clase que refleja los datos de la planilla agrupados por año
    public class PlanillaDataAnio
    {
        public string Año { get; set; }  // Año agrupado
        public decimal TotalSalario { get; set; }  // Total de salario por año
    }
}
