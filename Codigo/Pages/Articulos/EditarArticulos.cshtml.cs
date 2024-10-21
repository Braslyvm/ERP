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
public class EditarArticulo : PageModel{
         public string ErrorMessage { get; set; }
          // Cadena de conexión para la base de datos
 private readonly string _connectionString;

 // Constructor que recibe la configuración y obtiene la cadena de conexión
 public EditarArticulo(IConfiguration configuration)
 {
     _connectionString = configuration.GetConnectionString("DefaultConnection");
 }

 // Propiedades que se vinculan a los campos del formulario
 [BindProperty]
 public string c_articulo { get; set; }
 [BindProperty]
 public string nombreA { get; set; }
 
 [BindProperty]
public int activo { get; set; }
[BindProperty]
public string descripcion { get; set; }
 [BindProperty]
 public string cfamilia { get; set; }
 [BindProperty]
 public int peso { get; set; }
 [BindProperty]
 public int costo { get; set; }
 [BindProperty]
 public int precio { get; set; }
 [BindProperty]

/*Listas de la clase*/
public List<Articulo> articulos { get; set; }= new List<Articulo>();
public List<Familia> familias { get; set; }= new List<Familia>();

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