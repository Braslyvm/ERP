using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using SqlConnection = Microsoft.Data.SqlClient.SqlConnection;
using SqlCommand = Microsoft.Data.SqlClient.SqlCommand;
using SqlDataReader = Microsoft.Data.SqlClient.SqlDataReader;
using System.Data;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
    public class ModificarinfoUsuario : PageModel
    {
        public string ErrorMessage { get; set; }
        private readonly string _connectionString;
        private readonly ILogger<ModificarinfoUsuario> _logger;
        public ModificarinfoUsuario(IConfiguration configuration, ILogger<ModificarinfoUsuario> logger)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            _logger = logger;
        }
        [BindProperty]
        public int Cedula { get; set; }
        [BindProperty]
        public string SuccessMessage { get; set; }

        [BindProperty]
        public string Nombre { get; set; }
        [BindProperty]
        public string Apellido1 { get; set; }
        [BindProperty]
        public string Apellido2 { get; set; }
        [BindProperty]
        public string Genero { get; set; }
        [BindProperty]
        public DateTime?  FechaNacimiento { get; set; }
         [BindProperty]
 public DateTime?  FechaFin { get; set; }
        [BindProperty]
        public string LugarResidencia { get; set; }
        [BindProperty]
        public int Telefono { get; set; }
        [BindProperty]
        public int SalarioActual { get; set; }
        [BindProperty]
        public string? PuestoActual { get; set; }
        [BindProperty]
        public string CorreoE { get; set; }
        [BindProperty]
   public string Contraseña { get; set; }

        [BindProperty]
public string? puesto { get; set; }
[BindProperty]
public string? departamento { get; set; }
        public List<Puesto> Puestos { get; set; } = new List<Puesto>();
        public List<Empleado> Empleados { get; set; } = new List<Empleado>();

        public async Task<IActionResult> OnGetAsync()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Obtener lista de puestos
                string sqlPuestos = "SELECT id_puesto, id_departamento FROM usuarios.puesto;";
                using (SqlCommand commandPuestos = new SqlCommand(sqlPuestos, connection))
                {
                    using (SqlDataReader reader = await commandPuestos.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Puesto puesto = new Puesto
                            {
                                PuestoT = reader["id_puesto"].ToString(),
                                Departamento = reader["id_departamento"].ToString()
                            };
                            Puestos.Add(puesto);
                        }
                    }
                }

                // Obtener lista de empleados
                string sqlEmpleados = "SELECT cedula, nombre, apellido1 FROM usuarios.ObtenerEmpleados();";
                using (SqlCommand commandEmpleados = new SqlCommand(sqlEmpleados, connection))
                {
                    using (SqlDataReader reader = await commandEmpleados.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Empleado empleado = new Empleado
                            {
                                Cedula = Convert.ToInt32(reader["cedula"]),
                                Nombre = reader["nombre"].ToString(),
                                Apellido1 = reader["apellido1"].ToString(),
                            };
                            Empleados.Add(empleado);
                        }
                    }
                }
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()

        {   if (PuestoActual != null){
            var puestoInfo = PuestoActual.Split(';');
            var puesto = puestoInfo[0];
            var departamento = puestoInfo[1];}
                                          
            
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("usuarios.actualizar_empleado", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@cedula", Cedula);
                    command.Parameters.AddWithValue("@nombre", Nombre);
                    command.Parameters.AddWithValue("@apellido1", Apellido1);
                    command.Parameters.AddWithValue("@apellido2", Apellido2);
                    command.Parameters.AddWithValue("@correo_electronico", CorreoE);
                    command.Parameters.AddWithValue("@contraseña", Contraseña);
                    command.Parameters.AddWithValue("@género", Genero);
                    command.Parameters.AddWithValue("@fecha_nacimiento", FechaNacimiento);
                    command.Parameters.AddWithValue("@lugar_residencia", LugarResidencia);
                    command.Parameters.AddWithValue("@telefono", Telefono);
                    command.Parameters.AddWithValue("@fecha_ingreso", DateTime.Now);
                    command.Parameters.AddWithValue("@salario_actual", SalarioActual);
                    command.Parameters.AddWithValue("@puesto_actual", puesto);
                    command.Parameters.AddWithValue("@departamento_actual", departamento);
                    command.Parameters.AddWithValue("@rol", "rol");

                    SqlParameter mensajeParameter = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(mensajeParameter);

                    await connection.OpenAsync();
                    await command.ExecuteNonQueryAsync();

                    string mensaje = mensajeParameter.Value.ToString();
                    _logger.LogInformation(mensaje);
                    SuccessMessage = mensaje;
                }
    
            }
            if (SalarioActual != 0)  {
                     using (SqlConnection connection = new SqlConnection(_connectionString))
                    {
                        using (SqlCommand command = new SqlCommand("usuarios.Hsalarios", connection))
                     {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@cedula", Cedula);
                    command.Parameters.AddWithValue("@FechaInicio", DateTime.Now);
                    command.Parameters.AddWithValue("@monto", SalarioActual);
               
               
               

                    
                     SqlParameter mensajeParameter = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
                {
                Direction = ParameterDirection.Output
                };
                command.Parameters.Add(mensajeParameter);

                      await connection.OpenAsync();
                await command.ExecuteNonQueryAsync();
                string mensaje = mensajeParameter.Value.ToString();
                _logger.LogInformation(mensaje);
                SuccessMessage = mensaje;

                     }
            }
         
        }
        if (PuestoActual != null){
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            using (SqlCommand command = new SqlCommand("usuarios.HPuestos", connection))
         {
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@cedula", Cedula);
        command.Parameters.AddWithValue("@FechaInicio", DateTime.Now);
        
         SqlParameter mensajeParameter = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
    {
    Direction = ParameterDirection.Output
    };
    command.Parameters.Add(mensajeParameter);
          await connection.OpenAsync();
    await command.ExecuteNonQueryAsync();
    string mensaje = mensajeParameter.Value.ToString();
    _logger.LogInformation(mensaje);
    SuccessMessage = mensaje;
         }
}













        }
           return RedirectToPage();
    }
}
}