using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
    public class CotizacionesVentasModel : PageModel
    {
        private readonly string _connectionString;

        public List<DepartamentoData> Departamentos { get; set; } = new List<DepartamentoData>();

        [BindProperty(SupportsGet = true)]
        public DateTime? FechaInicio { get; set; }

        [BindProperty(SupportsGet = true)]
        public DateTime? FechaFin { get; set; }

        public CotizacionesVentasModel(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task<IActionResult> OnGetAsync()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                
                using (var command = new SqlCommand("SELECT * FROM CotizacionesyVentas(@fecha_inicio, @fecha_fin)", connection))
                {
                    command.Parameters.AddWithValue("@fecha_inicio", (object)FechaInicio ?? DBNull.Value);
                    command.Parameters.AddWithValue("@fecha_fin", (object)FechaFin ?? DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Departamentos.Add(new DepartamentoData
                            {
                                Departamento = reader["departamento_actual"].ToString(),
                                CantidadCotizacion = reader["cantidadCotizacion"] != DBNull.Value ? (int)reader["cantidadCotizacion"] : 0,
                                CantidadVentas = reader["cantidadVentas"] != DBNull.Value ? (int)reader["cantidadVentas"] : 0
                            });
                        }
                    }
                }
            }
            return Page();
        }
    }

    public class DepartamentoData
    {
        public string Departamento { get; set; }
        public int CantidadCotizacion { get; set; }
        public int CantidadVentas { get; set; }
    }
}
