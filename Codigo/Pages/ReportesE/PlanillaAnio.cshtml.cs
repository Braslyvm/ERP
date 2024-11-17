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
    public string? MesInicio { get; set; }
    public int? AnioFin { get; set; }
    public string? MesFin { get; set; }

    public MAño(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    public async Task<IActionResult> OnGetAsync(int? anioInicio, string? mesInicio, int? anioFin, string? mesFin)
    {
        AnioInicio = anioInicio;
        MesInicio = mesInicio;
        AnioFin = anioFin;
        MesFin = mesFin;

        using (var connection = new SqlConnection(_connectionString))
        {
            await connection.OpenAsync();

            // Consulta SQL con parámetros para los años y meses
            var query = "SELECT * FROM usuarios.PlanillaMesse(@anioInicio, @mesInicio, @anioFin, @mesFin)";

            using (var command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@anioInicio", (object)AnioInicio ?? DBNull.Value);
                command.Parameters.AddWithValue("@mesInicio", (object)MesInicio ?? DBNull.Value);
                command.Parameters.AddWithValue("@anioFin", (object)AnioFin ?? DBNull.Value);
                command.Parameters.AddWithValue("@mesFin", (object)MesFin ?? DBNull.Value);

                using (var reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        Planilla.Add(new PlanillaDataAnio
                        {
                            Año = reader["año"].ToString(),
                            Mes = reader["mes"].ToString(),
                            TotalSalario = reader["total_salario"] != DBNull.Value ? decimal.Parse(reader["total_salario"].ToString()) : 0
                        });
                    }
                }
            }
        }
        return Page();
    }
}

public class PlanillaDataAnio
{
    public string Año { get; set; }
    public string Mes { get; set; }
    public decimal TotalSalario { get; set; }
}



   
}
