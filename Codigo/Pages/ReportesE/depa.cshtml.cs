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

    public async Task<IActionResult> OnGetAsync()
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            await connection.OpenAsync();
            using (var command = new SqlCommand("usuarios.planilldepa", connection)) // Llama el procedimiento almacenado
            {
                command.CommandType = CommandType.StoredProcedure;

                using (var reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync()) // Lee cada fila de los resultados
                    {
                        Planilla.Add(new PlanillaDataDeptoMes 
                        {
                            Departamento = reader["departamento"].ToString(),
                            Mes = reader["mes"].ToString(),
                            TotalSalario = decimal.Parse(reader["total_salario"].ToString())
                        });
                    }
                }
            }
        }
        return Page();
    }
}

// Clase que refleja los datos de la planilla agrupados por departamento y mes
public class PlanillaDataDeptoMes
{
    public string Departamento { get; set; }  // Departamento
    public string Mes { get; set; }           // Mes
    public decimal TotalSalario { get; set; } // Total de salario por mes y departamento
}
}