using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using SqlConnection = Microsoft.Data.SqlClient.SqlConnection;
using SqlCommand = Microsoft.Data.SqlClient.SqlCommand;
using SqlDataReader = Microsoft.Data.SqlClient.SqlDataReader;

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

        // Método que se ejecuta cuando se carga la página con una solicitud GET
        public async Task<IActionResult> OnGetAsync()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                string sql = "SELECT id_puesto, id_departamento FROM usuarios.puesto;";
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
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

                // Logging de prueba
                foreach (var puesto in Puestos)
                {
                    _logger.LogInformation($"ID Puesto: {puesto.PuestoT}, ID Departamento: {puesto.Departamento}");
                }
            }

            return Page();
        }

        // Método que se ejecuta cuando se envía el formulario
        public async Task<IActionResult> OnPostAsync()
        {
            // Aquí puedes agregar el código para guardar el usuario en la base de datos
            // Usar la información de las propiedades enlazadas (Cedula, Nombre, etc.)
            // Para guardar en la base de datos, asegúrate de abrir una conexión y ejecutar el comando SQL correspondiente

            return RedirectToPage("./Index");
        }
    }
}
