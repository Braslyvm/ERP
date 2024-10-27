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
    public class TareaCotizacion : PageModel{
        public int IdCotizacion { get; set; }
        public int Cedula { get; set; }
        public string descripcion { get; set; }
        public string fechaLimite { get; set; }
        public string estado { get; set; }
        public List<(int Id, string nombre)> Empleados { get; set; } = new List<(int, string)>();  
        public List<int> Cotizacion { get; set; }= new List<int>();
        
        private readonly string _connectionString;
        public TareaCotizacion(IConfiguration configuration){
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public async Task<IActionResult> OnGetAsync(){
            Cotizacion = GetCotizacion();
            Empleados = GetEmpleados(); 
            return Page();
        }
        // Método que se ejecuta cuando se envía el formulario con una solicitud POST
        public async Task<IActionResult> OnPostAsync(){
            Cedula = int.Parse(Request.Form["Cedula"]);
            IdCotizacion = int.Parse(Request.Form["IdCotizacion"]);
            descripcion = Request.Form["descripcion"];
            fechaLimite = Request.Form["fechaLimite"].ToString(); 
            estado = Request.Form["estado"];
            DateTime fechalimi;
            fechalimi = DateTime.ParseExact(fechaLimite, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            await crearTarea(Cedula, IdCotizacion,descripcion,fechalimi,estado);

            // Establece un mensaje en TempData
            TempData["SuccessMessage"] = "La tarea se ha asignado correctamente.";
            
            // Redirige de nuevo a la página
            return RedirectToPage();
        }

        public List<int> GetCotizacion(){
            var cotizaciones = new List<int>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT id_cotizacion FROM dbo.cotizaciones()", conexion);
                conexion.Open();
                using (var reader = command.ExecuteReader()){
                    while (reader.Read()){
                        var id_cotizacion = reader.GetInt32(0);   
                        cotizaciones.Add(id_cotizacion);
                    }
                }
            }
            return cotizaciones;
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
        public async Task crearTarea(int cedula , int IdCotizacion, string descripcion, DateTime fechalimi, string estado){
            using (var conexion = new SqlConnection(_connectionString)){
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC cotizaciones.insertar_tarea @id_cotizacion , @descripcion, @usuario, @fecha_limite, @estado, @mensaje OUTPUT" , conexion);
                comando.Parameters.AddWithValue("@id_cotizacion", IdCotizacion);
                comando.Parameters.AddWithValue("@descripcion", descripcion);
                comando.Parameters.AddWithValue("@usuario", cedula);
                comando.Parameters.AddWithValue("@fecha_limite", fechalimi);
                comando.Parameters.AddWithValue("@estado", estado);
                var mensajeParametro = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200){
                    Direction = ParameterDirection.Output
                };
                comando.Parameters.Add(mensajeParametro);

                await comando.ExecuteNonQueryAsync();
                
                string mensajeSalida = (string)mensajeParametro.Value;
            }
        }
    }
}