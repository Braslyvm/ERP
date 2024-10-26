using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;


namespace proyecto1bases.Pages {
    public class AsignarRol : PageModel{
        public bool funciono { get; set; } = false;
        [BindProperty]
         public List<(int Id, string nombre)> Empleados { get; set; } = new List<(int, string)>();        
         public List<string> roles { get; set; }= new List<string>();

        public string rol { get; set; }
        [BindProperty]
        public int Cedula { get; set; }
        
        private readonly string _connectionString;
        
        public AsignarRol(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public async Task<IActionResult> OnGetAsync(bool? success){
            Empleados = GetEmpleados();
            roles = GetRoles();
            
            funciono = success ?? false;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(){
            Cedula = int.Parse(Request.Form["Cedula"]);
            rol = Request.Form["rol"];

            await asignarol(Cedula, rol);

            return RedirectToPage(new { success = true });
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
        public List<string> GetRoles(){
            var roles = new List<string>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT nombre FROM dbo.roles()", conexion);
                conexion.Open();

                using (var reader = command.ExecuteReader()){
                    while (reader.Read())
                    {
                        var role = reader.GetString(0);    
                        roles.Add(role);
                    }
                }
            }
            return roles;
        }
        public async Task asignarol (int cedula, string rol){
            using (var conexion = new SqlConnection(_connectionString)){
                await conexion.OpenAsync();
                
                var comando = new SqlCommand("EXEC usuarios.actualizar_empleado @cedula, @nombre, @apellido1, @apellido2, @correo_electronico, @contraseña, @género, @fecha_nacimiento, @lugar_residencia, @telefono, @fecha_ingreso, @salario_actual, @puesto_actual, @departamento_actual, @rol, @mensaje OUTPUT", conexion);
                comando.Parameters.AddWithValue("@cedula", cedula);
                comando.Parameters.AddWithValue("@nombre", DBNull.Value); 
                comando.Parameters.AddWithValue("@apellido1", DBNull.Value); 
                comando.Parameters.AddWithValue("@apellido2", DBNull.Value);
                comando.Parameters.AddWithValue("@correo_electronico", DBNull.Value); 
                comando.Parameters.AddWithValue("@contraseña", DBNull.Value); 
                comando.Parameters.AddWithValue("@género", DBNull.Value); 
                comando.Parameters.AddWithValue("@fecha_nacimiento", DBNull.Value);
                comando.Parameters.AddWithValue("@lugar_residencia", DBNull.Value);
                comando.Parameters.AddWithValue("@telefono", DBNull.Value); 
                comando.Parameters.AddWithValue("@fecha_ingreso", DBNull.Value);
                comando.Parameters.AddWithValue("@salario_actual", DBNull.Value); 
                comando.Parameters.AddWithValue("@puesto_actual", DBNull.Value);
                comando.Parameters.AddWithValue("@departamento_actual", DBNull.Value); 
                comando.Parameters.AddWithValue("@rol", rol);
                
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