using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;
namespace proyecto1bases.Pages {
  
// Página de modelo para la gestión de planillas
    public class EditarCotizacion : PageModel{
        public int  Cedula { get; set; }
        public int IdCotizacion { get; set; }
        public string? M_cierre { get; set; }
        public int? Probabilidad { get; set; }
        public string? Tipo { get; set; }
        public string? Estado { get; set; }
        public string? M_denegacion { get; set; }
        public string? Descripcion { get; set; }

        public List<int> Cotizacion { get; set; }= new List<int>();
         public bool funciono { get; set; } 
        
        private readonly string _connectionString;

        public EditarCotizacion(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            Cedula = configuration.GetSection("Cedulas").Get<int[]>().FirstOrDefault();
        }
        public async Task<IActionResult> OnGetAsync(bool? success){
            Cotizacion = GetCotizacion();
            
            funciono = success ?? false;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(){
            IdCotizacion = int.Parse(Request.Form["IdCotizacion"]);
            M_cierre = Request.Form["M_cierre"].Count > 0 ? Request.Form["M_cierre"].ToString() : null;
            string probabilidadValue = Request.Form["Probabilidad"];
            if (!string.IsNullOrEmpty(probabilidadValue) && int.TryParse(probabilidadValue, out int probabilidad)){
                Probabilidad = probabilidad;
            }
            else{
                Probabilidad = null;
            }
            Tipo = Request.Form["Tipo"].Count > 0 ? Request.Form["Tipo"].ToString() : null;
            Estado = Request.Form["Estado"].Count > 0 ? Request.Form["Estado"].ToString() : null;
            M_denegacion = Request.Form["M_denegacion"].Count > 0 ? Request.Form["M_denegacion"].ToString() : null;


            // Llama al método para actualizar la cotización
            var mensaje = await ActualizarCotizacion(IdCotizacion, M_cierre, Probabilidad, Tipo, Estado, M_denegacion);
            TempData["Mensaje"] = mensaje; 

            return RedirectToPage(new { success = true });
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


        private async Task<string> ActualizarCotizacion(int id_cotizacion, string? m_cierre, int? probabilidad, string? tipo, string? estado, string? m_denegacion){
            string mensaje;

            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();

                var comando = new SqlCommand("cotizaciones.actualizar_cotizacion", conexion)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                comando.Parameters.AddWithValue("@id_cotizacion", id_cotizacion);
                if (m_cierre == "" )
                    comando.Parameters.AddWithValue("@m_cierre", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@m_cierre", m_cierre);

                if (probabilidad == null )
                    comando.Parameters.AddWithValue("@probabilidad", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@probabilidad", probabilidad);

                if (tipo == "" ) {
                    comando.Parameters.AddWithValue("@tipo", DBNull.Value);
                }
                else   
                    comando.Parameters.AddWithValue("@tipo", tipo);

                if (estado == "" )
                    comando.Parameters.AddWithValue("@estado", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@estado", estado);

                if (m_denegacion == "" )
                    comando.Parameters.AddWithValue("@m_denegacion", DBNull.Value);
                else   
                    comando.Parameters.AddWithValue("@m_denegacion", m_denegacion);

                if (estado == "denegada")
                    comando.Parameters.AddWithValue("@contra_quien", Cedula);
                else   
                    comando.Parameters.AddWithValue("@contra_quien", DBNull.Value);

                var mensajeParametro = new SqlParameter("@mensaje", System.Data.SqlDbType.NVarChar, 200)
                {
                    Direction = System.Data.ParameterDirection.Output
                };
                comando.Parameters.Add(mensajeParametro);

                await comando.ExecuteNonQueryAsync();

                mensaje = (string)mensajeParametro.Value;
            }

            return mensaje;
        }
    }
}
