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
public class Gbodegas : PageModel{

 [BindProperty]
 public string BodegaN { get; set; }
[BindProperty]
public string Ubicacion { get; set; }
[BindProperty]
public int c_toneladas { get; set; }
[BindProperty]
public int e_cubico { get; set; }

 
private readonly string _connectionString;

public Gbodegas(IConfiguration configuration)
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