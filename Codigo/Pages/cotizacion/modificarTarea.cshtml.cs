using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;
using System.Globalization;
using System;

namespace proyecto1bases.Pages{
  
// Página de modelo para la gestión de planillas
    public class modificarTarea : PageModel{        
        public int IdTarea { get; set; }
        public string? Descripcion { get; set; }
        public string? FechaLimite { get; set; }
        public string? Estado { get; set; }
        public List<int> Tareas { get; set; } = new List<int>();
        public List<(int Id, string nombre)> Empleados { get; set; } = new List<(int, string)>();  
        public int? Cedula { get; set; }
        
        private readonly string _connectionString;

        public modificarTarea(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync(){
            Tareas = await GetTareasAsync();
            Empleados = GetEmpleados(); 
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(){
            IdTarea = int.Parse(Request.Form["IdTarea"]);
            Cedula = Request.Form["Cedula"].Count > 0 ? int.Parse(Request.Form["Cedula"]) : (int?)null;
            Descripcion = Request.Form["Descripcion"].Count > 0 ? Request.Form["Descripcion"].ToString() : null;
            Estado = Request.Form["Estado"].Count > 0 ? Request.Form["Estado"].ToString() : null;
            FechaLimite = Request.Form["FechaLimite"].Count > 0 ? Request.Form["FechaLimite"].ToString() : null;
            string mensaje = await ActualizarTareaAsync(IdTarea, Descripcion, FechaLimite, Estado, Cedula);
            TempData["SuccessMessage"] = mensaje;
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
        public List<(int Id, string nombre)> GetEmpleados(){
            var empleados = new List<(int, string)>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT cedula, nombre FROM dbo.usuarios()", conexion);
                conexion.Open();

                using (var leer = command.ExecuteReader()){
                    while (leer.Read()){
                        var id = leer.GetInt32(0);  
                        var nombre = leer.GetString(1);    
                        empleados.Add((id, nombre));
                    }
                }
            }
            return empleados;
        }

        private async Task<string> ActualizarTareaAsync(int idTarea, string? descripcion, string? fechaLimite, string? estado, int? cedula)
        {
            string mensaje;

            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("cotizaciones.actualizar_tarea", conexion)
                {
                    CommandType = CommandType.StoredProcedure
                };
                comando.Parameters.AddWithValue("@id_tarea", idTarea);
                if (descripcion == "" || descripcion == null)
                    comando.Parameters.AddWithValue("@descripcion", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@descripcion", descripcion);
                if (cedula == null )
                    comando.Parameters.AddWithValue("@usuario", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@usuario", cedula);
                if (fechaLimite == "" || fechaLimite == null)
                    comando.Parameters.AddWithValue("@fecha_limite", DBNull.Value);
                else  {
                    DateTime fechalimi;
                    fechalimi = DateTime.ParseExact(fechaLimite, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    comando.Parameters.AddWithValue("@fecha_limite", fechalimi);
                }
                if (estado == "" || estado == null)
                    comando.Parameters.AddWithValue("@estado", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@estado", estado);

                var mensajeParametro = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                comando.Parameters.Add(mensajeParametro);

                await comando.ExecuteNonQueryAsync();
                mensaje = (string)mensajeParametro.Value;
            }
            return mensaje;
        }
    }
}