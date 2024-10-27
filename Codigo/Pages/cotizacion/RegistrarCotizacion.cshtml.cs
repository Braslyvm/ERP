using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;

namespace proyecto1bases.Pages{
  
// Página de modelo para la gestión de planillas
    public class Cotizar : PageModel{
        public int  Cedula { get; set; }
        public int Cliente { get; set; }
        public string  M_cierre { get; set; }
        public int  Probabilidad { get; set; }
        public string Tipo { get; set; }
        public string Descripcion { get; set; }
        public List<(int Id, string nombre)> Clientes { get; set; } = new List<(int, string)>();  

        public bool funciono { get; set; } 
    
        private readonly string _connectionString;

        public Cotizar(IConfiguration configuration){
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            Cedula = configuration.GetSection("Cedulas").Get<int[]>().FirstOrDefault();
        }
        public async Task<IActionResult> OnGetAsync(bool? success){
            Clientes = getClientes();
            funciono = success ?? false;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(){
            Cliente = int.Parse(Request.Form["Cliente"]);
            Probabilidad = int.Parse(Request.Form["Probabilidad"]);
            M_cierre = Request.Form["M_cierre"];
            Tipo = Request.Form["Tipo"];
            Descripcion = Request.Form["Descripcion"];


            await InsertarCotizacion(Cedula, Cliente , M_cierre , Probabilidad, Tipo, Descripcion);
            return RedirectToPage(new { success = true });
        }   



        public List<(int Id, string nombre)> getClientes(){
            var clientes = new List<(int, string)>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT cedula, nombre FROM dbo.clientes ()", conexion);
                conexion.Open();

                using (var leer = command.ExecuteReader()){
                    while (leer.Read()){
                        var id = leer.GetInt32(0);  
                        var nombre = leer.GetString(1);    
                        clientes.Add((id, nombre));
                    }
                }
            }
            return clientes;
        }
         public async Task InsertarCotizacion(int cedula, int cliente, string m_cierre, int probabilidad, string tipo, string descripcion){
            
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();

                var comando = new SqlCommand("EXEC cotizaciones.insertar_cotizacion @cliente, @empleado, @m_cierre, @probabilidad, @tipo, @descripcion, @mensaje OUTPUT", conexion);
                comando.Parameters.AddWithValue("@cliente", cliente);
                comando.Parameters.AddWithValue("@empleado", cedula);
                comando.Parameters.AddWithValue("@m_cierre", m_cierre);
                comando.Parameters.AddWithValue("@probabilidad", probabilidad);
                comando.Parameters.AddWithValue("@tipo", tipo);
                comando.Parameters.AddWithValue("@descripcion", descripcion);

                var mensajeParametro = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                comando.Parameters.Add(mensajeParametro);

                await comando.ExecuteNonQueryAsync();

                string mensajeSalida = (string)mensajeParametro.Value;
            }
        }
    }
}