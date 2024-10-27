using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using SqlConnection = Microsoft.Data.SqlClient.SqlConnection;
using SqlCommand = Microsoft.Data.SqlClient.SqlCommand;
using SqlDataReader = Microsoft.Data.SqlClient.SqlDataReader;
using System.Data;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace proyecto1bases.Pages
{
    public class ListarModel : PageModel
    {
        public string ErrorMessage { get; set; }
        private readonly string _connectionString;
        private readonly ILogger<RegistroUsuarioModel> _logger;

        public ListarModel(IConfiguration configuration, ILogger<RegistroUsuarioModel> logger)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            _logger = logger;
        }

        // Propiedades para el formulario
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

        // Listas para Puestos y Empleados
        public List<Puesto> Puestos { get; set; } = new List<Puesto>();
        public List<Empleado> Empleados { get; set; } = new List<Empleado>();

        // Método que se ejecuta al cargar la página
        public async Task<IActionResult> OnGetAsync()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Consulta para obtener los empleados usando la función usuarios.ObtenerEmpleados()
                string sqlEmpleados = "SELECT * FROM usuarios.ObtenerEmpleados();";
                using (SqlCommand command = new SqlCommand(sqlEmpleados, connection))
                {
                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Empleado empleado = new Empleado
                            {
                                Cedula = reader.GetInt32(reader.GetOrdinal("cedula")),
                                Nombre = reader.GetString(reader.GetOrdinal("nombre")),
                                Apellido1 = reader.GetString(reader.GetOrdinal("apellido1")),
                                Apellido2 = reader.GetString(reader.GetOrdinal("apellido2")),
                                CorreoElectronico = reader.GetString(reader.GetOrdinal("Correo_Electronico")),
                                Genero = reader.GetString(reader.GetOrdinal("género")),
                                FechaNacimiento = reader.GetDateTime(reader.GetOrdinal("fecha_nacimiento")),
                                Edad = reader.GetInt32(reader.GetOrdinal("edad")),
                                LugarResidencia = reader.GetString(reader.GetOrdinal("lugar_residencia")),
                                Telefono = reader.GetInt32("Telefono"),
                                FechaIngreso = reader.GetDateTime(reader.GetOrdinal("fecha_ingreso")),
                                SalarioActual = reader.GetInt32(reader.GetOrdinal("salario_actual")),
                                PuestoActual = reader.GetString(reader.GetOrdinal("puesto_actual")),
                                DepartamentoActual = reader.GetString(reader.GetOrdinal("departamento_actual")),
                                Rol = reader.GetString(reader.GetOrdinal("rol"))
                            };
                            Empleados.Add(empleado);
                        }
                    }
                }
            }
            return Page();
        }
    }
}
