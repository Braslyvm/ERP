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
    public class RegistroUsuarioModel : PageModel
    {
        public string ErrorMessage { get; set; }

        // Cadena de conexión para la base de datos
        private readonly string _connectionString;
        private readonly ILogger<RegistroUsuarioModel> _logger;

        // Constructor que recibe la configuración y obtiene la cadena de conexión
        public RegistroUsuarioModel(IConfiguration configuration, ILogger<RegistroUsuarioModel> logger)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            _logger = logger;
        }

        // Propiedades que se vinculan a los campos del formulario
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
        public DateTime FechaNacimiento { get; set; }

        [BindProperty]
        public string LugarResidencia { get; set; }

        [BindProperty]
        public int Telefono { get; set; }

        [BindProperty]
        public int SalarioActual { get; set; }

        [BindProperty]
        public string PuestoActual { get; set; }

        [BindProperty]
        public string CorreoE { get; set; }

        [BindProperty]
        public string Contraseña { get; set; }

        // Lista de puestos
        public List<Puesto> Puestos { get; set; } = new List<Puesto>();
            public List<Empleado> empleados { get; set; } = new List<Empleado>();

        // Método que se ejecuta cuando se carga la página 
        public async Task<IActionResult> OnGetAsync()
        {
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
            
            return Page(); 
        }

        // Método que se ejecuta cuando se envía el formulario
        public async Task<IActionResult> OnPostAsync()
        {

            var puestoInfo = PuestoActual.Split(';');
        
        
            var puesto = puestoInfo[0];       
            var departamento = puestoInfo[1];  
            // Crear una conexión a la base de datos
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                // Crear un comando para ejecutar el procedimiento almacenado
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
                    command.Parameters.AddWithValue("@departamento_actual",departamento );
                    command.Parameters.AddWithValue("@rol", "rol"); 
                    

                  
                    SqlParameter mensajeParameter = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200);
                    mensajeParameter.Direction = ParameterDirection.Output; // Definir el parámetro como salida
                    command.Parameters.Add(mensajeParameter);

                        // Abrir la conexión a la base de datos
                        await connection.OpenAsync();
                        
                        // Ejecutar el procedimiento almacenado
                        await command.ExecuteNonQueryAsync();

                        // Obtener el mensaje de salida del procedimiento
                        string mensaje = mensajeParameter.Value.ToString();
                        _logger.LogInformation(mensaje); // Registrar el mensaje en el log
                          SuccessMessage = mensaje; // Asigna el mensaje de éxito aquí
                        //ErrorMessage = "Ocurrió un error al registrar el usuario. Intente nuevamente."; // Mostrar mensaje al usuario
                    }
                }
            

            return RedirectToPage();; // Redirigir a la página principal después de la inserción
        }
    }
}
