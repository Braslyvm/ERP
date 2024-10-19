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
public class RegistroUsuario : PageModel{
         public string ErrorMessage { get; set; }
          // Cadena de conexión para la base de datos
 private readonly string _connectionString;

 // Constructor que recibe la configuración y obtiene la cadena de conexión
 public RegistroUsuario(IConfiguration configuration)
 {
     _connectionString = configuration.GetConnectionString("DefaultConnection");
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
 public DateOnly FechaNacimiento { get; set; }
 [BindProperty]
 public int edad { get; set; }
 [BindProperty]
 public string LugarResidencia { get; set; }
 [BindProperty]
 public int teléfono { get; set; }
 [BindProperty]
 public DateOnly FechaIngreso { get; set; }
 [BindProperty]
 public int SalariosActual { get; set; }
[BindProperty]
public string PuestoActual { get; set; }
[BindProperty]
public string DepartamentoActual { get; set; }
public List<Puesto> Puestos { get; set; }= new List<Puesto>();
 
public List<Departamento> departamentos { get; set; }= new List<Departamento>(); 

 // Método que se ejecuta cuando se carga la página con una solicitud GET
 public async Task<IActionResult> OnGetAsync()
 {
    Puestos = new List<Puesto>
        {
            new Puesto { IDpueto = 1, PuestoT = "Administrador" },
            new Puesto { IDpueto = 2, PuestoT = "Vendedor" },
            new Puesto { IDpueto = 3, PuestoT = "Contador" }
        };
         departamentos = new List<Departamento>
            {
                new Departamento { IDdepartamento = 1, NombreD = "Recursos Humanos" },
                new Departamento { IDdepartamento = 2, NombreD = "Contaduría" },
                new Departamento { IDdepartamento = 3, NombreD = "Ventas" }
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