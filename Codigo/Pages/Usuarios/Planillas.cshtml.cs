using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;
using System.Globalization;
using System;

namespace proyecto1bases.Pages
{
  
// Página de modelo para la gestión de planillas
    public class Planillas : PageModel{

    [BindProperty]
        public List<(int Id, string nombre)> Empleados { get; set; } = new List<(int, string)>();        

            [BindProperty]
        public int Cedula { get; set; }
        [BindProperty]
        public int Año { get; set; }
        [BindProperty]
        public int HorasE { get; set; }
        public string Mes { get; set; }
        [BindProperty]
        public int HorasN { get; set; }
        public string  fecha_pago { get; set; }
        public int  funciono { get; set; } = 0; 

        
        private readonly string _connectionString;

        public Planillas(IConfiguration configuration){
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public async Task<IActionResult> OnGetAsync(bool? success){
            Empleados = GetEmpleados();


            if(success == true){
                funciono = 1;
                return Page();
            }
            else if (success == false){
                funciono = 2;
                return Page();
            }

            funciono = 0;
            return Page();
        }
        public async Task<IActionResult> OnPostAsync() {
            Cedula = int.Parse(Request.Form["Cedula"]);
            Mes = Request.Form["Mes"];
            Año = int.Parse(Request.Form["Año"]); 
            HorasN = int.Parse(Request.Form["HorasN"]);
            HorasE = int.Parse(Request.Form["HorasE"]);
            
            fecha_pago = Request.Form["fecha_pago"].ToString(); 
            DateTime fechaPago;
            fechaPago = DateTime.ParseExact(fecha_pago, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            await PermisoCaso(Cedula, Mes,Año,fechaPago,HorasN,HorasE);

            if (funciono == 1 )
                return RedirectToPage(new { success = true });
            else 
                return RedirectToPage(new { success = false });
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
        public async Task PermisoCaso(int cedula , string mes, int año, DateTime fecha_pago, int horasn, int horase){
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.insertar_plantilla @cedula, @mes, @año, @fecha_pago, @h_normales, @h_extras, @mensaje OUTPUT" , conexion);
                comando.Parameters.AddWithValue("@cedula", cedula);
                comando.Parameters.AddWithValue("@mes", mes);
                comando.Parameters.AddWithValue("@año", año);
                comando.Parameters.AddWithValue("@fecha_pago", fecha_pago);
                comando.Parameters.AddWithValue("@h_normales", horasn);
                comando.Parameters.AddWithValue("@h_extras", horase);
                var mensajeParametro = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200){
                    Direction = ParameterDirection.Output
                };
                comando.Parameters.Add(mensajeParametro);

                await comando.ExecuteNonQueryAsync();
                
                string mensajeSalida = (string)mensajeParametro.Value;

                if (mensajeSalida == "registro de plantilla insertado exitosamente")
                    funciono = 1;
                else
                    funciono = 2;
            }
        }


    }
}