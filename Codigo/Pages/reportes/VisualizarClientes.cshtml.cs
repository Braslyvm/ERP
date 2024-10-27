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
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

                
       

                
        

           
        
        }

       
        
        public async Task<IActionResult> OnPostAsync()
{
   
       return null;
   }
   }

    
    }
    

