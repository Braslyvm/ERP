using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
//using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
  
// Página de modelo para la gestión de planillas
public class EliminarUsuario : PageModel{

 [BindProperty]
 public int Cedula { get; set; }
 [BindProperty]

public List<Empleado> empleados { get; set; }= new List<Empleado>();
 
private readonly string _connectionString;

public EliminarUsuario(IConfiguration configuration)
{
    _connectionString = configuration.GetConnectionString("DefaultConnection");
}
public async Task<IActionResult> OnGetAsync()
{
   
   
   
   
    return Page();
}
// Método que se ejecuta cuando se envía el formulario con una solicitud POST
public async Task<IActionResult> OnPostAsync()
{
   
       return null;
   }


}}