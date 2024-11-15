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
    public class Ventafam : PageModel
    {
        private readonly string _connectionString;

        public List<FamiliaProductosData> FamiliaProductosList { get; set; } = new List<FamiliaProductosData>();

        public Ventafam(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task<IActionResult> OnGetAsync(DateTime? fechaInicio, DateTime? fechaFin)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM FamiliaProductos(@fecha_inicio, @fecha_fin)", connection))
                {
                    // Parámetros de las fechas
                    command.Parameters.AddWithValue("@fecha_inicio", fechaInicio.HasValue ? fechaInicio.Value : (object)DBNull.Value);
                    command.Parameters.AddWithValue("@fecha_fin", fechaFin.HasValue ? fechaFin.Value : (object)DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            FamiliaProductosList.Add(new FamiliaProductosData
                            {
                                NombreFamilia = reader["nombreFam"].ToString(),
                                TotalMonto = decimal.Parse(reader["total"].ToString())
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class FamiliaProductosData
    {
        public string NombreFamilia { get; set; }
        public decimal TotalMonto { get; set; }
    }
}
