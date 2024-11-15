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

        // Propiedad para almacenar las tareas obtenidas
        public List<(int id_tarea, int id_cotizacion, string descripcion, int usuario, DateTime fecha_inicio, DateTime fecha_limite, string estado)> topTareasList { get; set; } = new List<(int, int, string, int, DateTime, DateTime, string)>();

        public topTareas(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            // Llamamos a la función que obtiene las tareas
            topTareasList = GetTopTareas();
            return Page();
        }

        public List<(int id_tarea, int id_cotizacion, string descripcion, int usuario, DateTime fecha_inicio, DateTime fecha_limite, string estado)> GetTopTareas()
        {
            var tareasList = new List<(int, int, string, int, DateTime, DateTime, string)>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SELECT id_tarea, id_cotizacion, descripcion, usuario, fecha_inicio, fecha_limite, estado FROM cotizaciones.top15_tareas()", conexion);
                conexion.Open();

                using (var leer = command.ExecuteReader())
                {
                    while (leer.Read())
                    {
                        // Lectura correcta de las columnas según su tipo
                        var idTarea = leer.GetInt32(0); // id_tarea es int
                        var idCotizacion = leer.GetInt32(1); // id_cotizacion es int
                        var descripcion = leer.GetString(2); // descripcion es string
                        var usuario = leer.GetInt32(3); // usuario es int
                        var fechaInicio = leer.GetDateTime(4); // fecha_inicio es DateTime
                        var fechaLimite = leer.GetDateTime(5); // fecha_limite es DateTime
                        var estado = leer.GetString(6); // estado es string

                        // Agregamos la tarea a la lista
                        tareasList.Add((idTarea, idCotizacion, descripcion, usuario, fechaInicio, fechaLimite, estado));
                    }
                }
            }
            return tareasList;
        }
    }
}
