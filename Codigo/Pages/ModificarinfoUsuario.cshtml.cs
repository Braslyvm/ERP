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
public class ModificarinfoUsuario : PageModel{
         public string ErrorMessage { get; set; }
          // Cadena de conexión para la base de datos
 private readonly string _connectionString;

 // Constructor que recibe la configuración y obtiene la cadena de conexión
 public ModificarinfoUsuario(IConfiguration configuration)
 {
     _connectionString = configuration.GetConnectionString("DefaultConnection");
 }

 // Propiedades que se vinculan a los campos del formulario
 [BindProperty]
 public int Cedula { get; set; }

 [BindProperty]
 public int SalariosActual { get; set; }
[BindProperty]
public string PuestoActual { get; set; }

public List<Empleado> empleados { get; set; }= new List<Empleado>();
public List<Puesto> Puestos { get; set; }= new List<Puesto>();


 // Método que se ejecuta cuando se carga la página con una solicitud GET
 public async Task<IActionResult> OnGetAsync()
 {
   Puestos = new List<Puesto>
    {
        new Puesto { IDpueto = 1, PuestoT = "Administrador" },
        new Puesto { IDpueto = 2, PuestoT = "Vendedor" },
        new Puesto { IDpueto = 3, PuestoT = "Contador" }
    };
   
   
   
   
   
        
        
        
        
        
        
    
    

     return Page();
 }

 // Método que se ejecuta cuando se envía el formulario con una solicitud POST
 public async Task<IActionResult> OnPostAsync()
 {
    
        return null;
    }

    }
    
}