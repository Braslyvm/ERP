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
    public class MAño : PageModel
    {
        private readonly string _connectionString;

        public List<PlanillaDataAnio> Planilla { get; set; } = new List<PlanillaDataAnio>();
        public int? AñoInicio { get; set; }
        public string? MesInicio { get; set; }
        public int? AñoFin { get; set; }
        public string? MesFin { get; set; }

        public MAño(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }


        public async Task<IActionResult> OnGetAsync(int? añoInicio, string? mesInicio, int? añoFin, string? mesFin)
        {  
            // Asignar los valores a las propiedades del modelo
            AñoInicio = añoInicio;
            MesInicio = mesInicio;
            AñoFin = añoFin;
            MesFin = mesFin;
              Console.WriteLine($"Año Inicio: {añoInicio}, Mes Inicio: {mesInicio}, Año Fin: {añoFin}, Mes Fin: {mesFin}");

            // Consultar los datos de la base de datos
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                var query = "SELECT * FROM [usuarios].[PlanillaMesse](@año_inicio, @mes_inicio, @año_fin, @mes_fin)";
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@año_inicio", (object)añoInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes_inicio", (object)mesInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@año_fin", (object)añoFin ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes_fin", (object)mesFin ?? DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Planilla.Add(new PlanillaDataAnio
                            {
                                Año = reader["año"]?.ToString() ?? string.Empty,
                                Mes = reader["mes"]?.ToString() ?? string.Empty,
                                TotalSalario = reader["total_salario"] != DBNull.Value 
                                    ? Convert.ToDecimal(reader["total_salario"]) 
                                    : 0
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