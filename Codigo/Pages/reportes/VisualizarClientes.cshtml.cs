using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
//using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    // Página de modelo para mostrar información de proyectos, empleados, tareas, actividades y seguimientos
    public class VisualizarClientes : PageModel
    {
        private readonly string _connectionString;

        // Constructor que recibe la configuración y obtiene la cadena de conexión
        public VisualizarClientes(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        // Listas para almacenar los datos de proyectos, empleados, tareas, actividades y seguimientos
        public List<Cliente> clientes { get; set; }
       
        
        
        

        // Método que se ejecuta cuando se carga la página con una solicitud GET
        public async Task OnGetAsync()
        {
            clientes = new List<Cliente>();
            clientes = new List<Cliente>
            {
                new Cliente
                {
                    CedulaJ = "123456789",
                    NombreC = "Distribuidora ABC",
                    CorreoE = "contacto@abc.com",
                    Telefono = "2222-3333",
                    celular = "8888-9999",
                    fax = "2222-4444",
                    zona = "Centro",
                    sector = "Comercial"
                },
                new Cliente
                {
                    CedulaJ = "987654321",
                    NombreC = "Inversiones XYZ",
                    CorreoE = "ventas@xyz.com",
                    Telefono = "5555-6666",
                    celular = "7777-8888",
                    fax = "5555-7777",
                    zona = "Norte",
                    sector = "Industrial"
                },
                new Cliente
                {
                    CedulaJ = "456789123",
                    NombreC = "Servicios La Estrella",
                    CorreoE = "info@laestrella.com",
                    Telefono = "3333-4444",
                    celular = "9999-0000",
                    fax = "3333-5555",
                    zona = "Sur",
                    sector = "Servicios"
                },
                new Cliente
                {
                    CedulaJ = "852369741",
                    NombreC = "Comercial El Buen Gusto",
                    CorreoE = "comercial@elbuen.com",
                    Telefono = "4444-5555",
                    celular = "6666-7777",
                    fax = "4444-8888",
                    zona = "Oeste",
                    sector = "Comercial"
                },
                new Cliente
                {
                    CedulaJ = "963258741",
                    NombreC = "TecnoSoluciones",
                    CorreoE = "support@tecnosol.com",
                    Telefono = "1111-2222",
                    celular = "3333-4444",
                    fax = "1111-5555",
                    zona = "Este",
                    sector = "Tecnología"
                }
            };

                
       

                
        

           
        
        }

       
        
        public async Task<IActionResult> OnPostAsync()
{
   
       return null;
   }
   }

    
    }
    

