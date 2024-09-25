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
public class TareaCotizacion : PageModel{

 [BindProperty]
 public int id_cotizacion { get; set; }
 [BindProperty]
public string descripcion { get; set; }

[BindProperty]
public DateOnly FechaL { get; set; }
[BindProperty]
public DateOnly FechaI { get; set; }
public string estado { get; set; }
public List<Empleado> empleados { get; set; }= new List<Empleado>();
 
private readonly string _connectionString;
public List<Cliente> clientes { get; set; }= new List<Cliente>();
public List<Cotizacion> cotizaciones { get; set; }= new List<Cotizacion>();
public TareaCotizacion(IConfiguration configuration)
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