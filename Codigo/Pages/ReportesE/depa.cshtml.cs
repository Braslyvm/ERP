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
   /// <summary>
      /// clase que muestra la planilla generada por cada departamenteo
      /// </summary>
      public class depa : PageModel
    {
        private readonly string _connectionString;

        public List<PlanillaDataDeptoMes> Planilla { get; set; } = new List<PlanillaDataDeptoMes>();

        /// <summary>
                /// string de conexion
                /// </summary>
               
                public depa(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        /// <summary>
        /// al iniciar la pagina se muestra toda la informacion en caso de recibir parametros se filtra
        /// </summary>
        /// <param name="departamento"></param>
        /// <param name="mes"></param>
        /// <returns></returns>
        public async Task<IActionResult> OnGetAsync(string? departamento, string?  mes)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Consulta a la función con valores de tabla
                var query = @"
                    SELECT departamento, mes, año, total_salario
                    FROM usuarios.planilla_por_departamentos(@departamento, @mes)";

                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@departamento", (object)departamento ?? DBNull.Value);
                    command.Parameters.AddWithValue("@mes", (object)mes ?? DBNull.Value);

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

    /// <summary>
        /// clase que almacena los tipos de datos
        /// </summary>
        public class PlanillaDataDeptoMes
    {
        public string Departamento { get; set; }
        public string Mes { get; set; }
        public string Año { get; set; }
        public decimal TotalSalario { get; set; }
    }
}
