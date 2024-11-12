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
        
        public MesAño(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync(string mes)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("usuarios.PlanillaMes", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    //command.Parameters.AddWithValue("@mes", mes);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Planilla.Add(new PlanillaData
                            {
                                Cedula = reader["cedula"].ToString(),
                                NombreCompleto = reader["nombre_completo"].ToString(),
                                Salario = decimal.Parse(reader["salario"].ToString()),
                                TotalSalario = decimal.Parse(reader["total_salario"].ToString()),
                                 mes =  reader["mes"].ToString(),
                                 año =  reader["año"].ToString(),
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
