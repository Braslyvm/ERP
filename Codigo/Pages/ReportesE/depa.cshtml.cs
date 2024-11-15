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
    public class depa : PageModel
    {
        private readonly string _connectionString;

        public List<PlanillaDataDeptoMes> Planilla { get; set; } = new List<PlanillaDataDeptoMes>();

        public depa(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task<IActionResult> OnGetAsync(string? departamento, int? año_inicio, int? mes_inicio, int? año_final, int? mes_final)
        {

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("usuarios.planilla_por_departamentos", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@departamento", (object)departamento ?? DBNull.Value);
                    command.Parameters.AddWithValue("@año_inicio", (object)año_inicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes_inicio", (object)mes_inicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@año_final", (object)año_final ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes_final", (object)mes_final ?? DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Planilla.Add(new PlanillaDataDeptoMes
                            {
                                Departamento = reader["departamento"].ToString(),
                                Mes = reader["mes"].ToString(),
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

    public class PlanillaDataDeptoMes
    {
        public string Departamento { get; set; }
        public string Mes { get; set; }
        public string Año { get; set; }
        public decimal TotalSalario { get; set; }
    }
}
