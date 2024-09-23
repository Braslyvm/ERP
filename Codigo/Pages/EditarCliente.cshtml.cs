using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
//using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
  
   
    // Página de modelo para la gestión de actividades
public class EditarCliente : PageModel{
         public string ErrorMessage { get; set; }
          // Cadena de conexión para la base de datos
 private readonly string _connectionString;

 // Constructor que recibe la configuración y obtiene la cadena de conexión
 public EditarCliente(IConfiguration configuration)
 {
     _connectionString = configuration.GetConnectionString("DefaultConnection");
 }

 // Propiedades que se vinculan a los campos del formulario } }
 [BindProperty]
public string CedulaJ { get; set; }
[BindProperty]
public string NombreC { get; set; }
[BindProperty]
public string CorreoE { get; set; }
[BindProperty]
public int Telefono { get; set; }
[BindProperty]
public string Fax { get; set; }
[BindProperty]
public string Zona { get; set; }
[BindProperty]
public string Sector { get; set; }

/*Listas de la clase*/
public List<Cliente> Clientes { get; set; }= new List<Cliente>();


 // Método que se ejecuta cuando se carga la página con una solicitud GET
 public async Task<IActionResult> OnGetAsync()
 {
    

     return Page();
 }

 // Método que se ejecuta cuando se envía el formulario con una solicitud POST
 public async Task<IActionResult> OnPostAsync()
 {
    
        return null;
    }

    }
    
}