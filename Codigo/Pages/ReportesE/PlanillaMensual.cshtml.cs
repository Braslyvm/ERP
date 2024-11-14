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
    public class MesAño : PageModel
    {
        private readonly string _connectionString;

        public List<PlanillaData> Planilla { get; set; } = new List<PlanillaData>();
        public int? AnioInicio { get; set; }
        public int? MesInicio { get; set; }
        public int? AnioFin { get; set; }
        public int? MesFin { get; set; }

        public MesAño(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync(int? anioInicio = null, int? mesInicio = null, 
                                                    int? anioFin = null, int? mesFin = null)
        {
            AnioInicio = anioInicio;
            MesInicio = mesInicio;
            AnioFin = anioFin;
            MesFin = mesFin;

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
               var query = @"
                   SELECT total_salario, mes, año
                   FROM usuarios.PlanillaMesse(@anio_inicio, @mes_inicio, @anio_fin, @mes_fin)";

                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@anio_inicio", (object)anioInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes_inicio", (object)mesInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@anio_fin", (object)anioFin ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes_fin", (object)mesFin ?? DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Planilla.Add(new PlanillaData
                            {
                               
                                
                                //Salario = decimal.Parse(reader["salario_actual"].ToString()),
                                TotalSalario = decimal.Parse(reader["total_salario"].ToString()),
                                mes = reader["mes"].ToString(),
                                año = reader["año"].ToString(),
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class PlanillaData
    {
        public string Cedula { get; set; }
        public string NombreCompleto { get; set; }
        public decimal Salario { get; set; }
        public decimal TotalSalario { get; set; }
        public string mes { get; set; }
        public string año { get; set; }
    }
}
