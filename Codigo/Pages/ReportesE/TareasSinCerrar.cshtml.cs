using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using System;

namespace proyecto1bases.Pages
{
    public class topTareas : PageModel
    {
        private readonly string _connectionString;

        public List<(int id_tarea, int id_cotizacion, string descripcion, int usuario, DateTime fecha_inicio, DateTime fecha_limite, string estado)> topTareasList { get; set; } = new List<(int, int, string, int, DateTime, DateTime, string)>();

        [BindProperty(SupportsGet = true)]
        public DateTime? FechaInicio { get; set; }

        [BindProperty(SupportsGet = true)]
        public DateTime? FechaFin { get; set; }

        public topTareas(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            topTareasList = GetTopTareas(FechaInicio, FechaFin);
            return Page();
        }

        /// <summary>
                ///  almacena los datos al iniciar la pagina 
                /// </summary>
                /// <param name="fechaInicio"></param>
                /// <param name="fechaFin"></param>
                /// <returns>tabla con las tareas mas viejas</returns>
                public List<(int id_tarea, int id_cotizacion, string descripcion, int usuario, DateTime fecha_inicio, DateTime fecha_limite, string estado)> GetTopTareas(DateTime? fechaInicio, DateTime? fechaFin)
        {
            var tareasList = new List<(int, int, string, int, DateTime, DateTime, string)>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                // Construimos la consulta con los parámetros opcionales de fechas
                var command = new SqlCommand("SELECT * FROM cotizaciones.top15_tareas(@fecha_inicio, @fecha_fin)", conexion);
                command.Parameters.AddWithValue("@fecha_inicio", (object)fechaInicio ?? DBNull.Value);
                command.Parameters.AddWithValue("@fecha_fin", (object)fechaFin ?? DBNull.Value);
                
                conexion.Open();

                using (var leer = command.ExecuteReader())
                {
                    while (leer.Read())
                    {
                        var idTarea = leer.GetInt32(0);
                        var idCotizacion = leer.GetInt32(1);
                        var descripcion = leer.GetString(2);
                        var usuario = leer.GetInt32(3);
                        var fechaInicioTarea = leer.GetDateTime(4);
                        var fechaLimite = leer.GetDateTime(5);
                        var estado = leer.GetString(6);

                        tareasList.Add((idTarea, idCotizacion, descripcion, usuario, fechaInicioTarea, fechaLimite, estado));
                    }
                }
            }
            return tareasList;
        }
    }
}
