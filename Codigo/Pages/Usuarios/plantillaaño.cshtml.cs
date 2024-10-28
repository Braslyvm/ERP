using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    public class añoPlantilla : PageModel
    {
        private readonly string _connectionString;

        public añoPlantilla(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public List<Dictionary<string, object>> Planillas { get; set; } = new List<Dictionary<string, object>>();

        [BindProperty(SupportsGet = true)]
        public int? Año { get; set; }

        public async Task<IActionResult> OnGetAsync()
        {
            if (Año.HasValue)
            {
                await LoadPlanillaByAñoAsync(Año.Value);
            }

            return Page();
        }

        private async Task LoadPlanillaByAñoAsync(int año)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (SqlCommand command = new SqlCommand("usuarios.planillaAño", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@año", año);

                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            var row = new Dictionary<string, object>
                            {
                                ["cedula"] = reader["cedula"],
                                ["nombre_completo"] = reader["nombre_completo"],
                                ["departamento"] = reader["departamento"],
                                ["h_normales"] = reader["h_normales"],
                                ["h_extras"] = reader["h_extras"],
                                ["salario_actual"] = reader["salario_actual"],
                                ["total_salario"] = reader["total_salario"]
                            };
                            Planillas.Add(row);
                        }
                    }
                }
            }
        }
    }
}
