using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    public class borrarTarea : PageModel
    {
        public int IdTarea { get; set; }
        public List<int> Tareas { get; set; } = new List<int>();

        private readonly string _connectionString;

        public borrarTarea(IConfiguration configuration){
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public async Task<IActionResult> OnGetAsync()
        {
            Tareas = await GetTareasAsync();
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            IdTarea = int.Parse(Request.Form["IdTarea"]);
            await BorrarTareaAsync(IdTarea);
            TempData["SuccessMessage"] = $"La tarea con ID {IdTarea} ha sido eliminada exitosamente.";
            return RedirectToPage();
        }

        private async Task<List<int>> GetTareasAsync(){
            var tareas = new List<int>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT id_tarea FROM dbo.tarea()", conexion);
                await conexion.OpenAsync();
                using (var reader = await command.ExecuteReaderAsync()){
                    while (await reader.ReadAsync()){
                        tareas.Add(reader.GetInt32(0)); 
                    }
                }
            }
            return tareas;
        }
        private async Task BorrarTareaAsync(int idTarea)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("cotizaciones.borrartareaporid", conexion)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                comando.Parameters.AddWithValue("@id_tarea", idTarea);

                await comando.ExecuteNonQueryAsync();
            }
        }
    }
}