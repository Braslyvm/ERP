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
public class Cotizar : PageModel{

 [BindProperty]
    public string CedulaJ { get; set; }

    [BindProperty]
    public DateTime Fecha { get; set; }

    [BindProperty]
    public DateTime FechaCierre { get; set; }

    [BindProperty]
    public string Probabilidad { get; set; }

    [BindProperty]
    public string Vendedor { get; set; }

    [BindProperty]
    public string Estado { get; set; }

    [BindProperty]
    public int Monto { get; set; }

    [BindProperty]
    public string Tipo { get; set; }

    [BindProperty]
    public string Descripcion { get; set; }

    [BindProperty]
    public List<string> ArticulosSeleccionados { get; set; } 
    
    public List<Cliente> clientes { get; set; } = new List<Cliente>();
    public List<Bodega> Bodegas { get; set; } = new List<Bodega>();
    public List<Articulo> articulos { get; set; } = new List<Articulo>();


 
private readonly string _connectionString;

public Cotizar(IConfiguration configuration)
{
    _connectionString = configuration.GetConnectionString("DefaultConnection");
}
public async Task<IActionResult> OnGetAsync()
{
   
     clientes.Add(new Cliente { NombreC = "Juan Pérez", CedulaJ = "30123456789" });
  Bodegas.Add(new Bodega { C_Bodega = 1, NombreB = "Bodega A" });
  Bodegas.Add(new Bodega { C_Bodega = 2, NombreB = "Bodega B" });
  articulos.Add(new Articulo { c_articulo = "1", nombreA = "Monitor 24\"" });
  articulos.Add(new Articulo { c_articulo = "2", nombreA = "Teclado Mecánico" });
  articulos.Add(new Articulo { c_articulo = "3", nombreA = "Ratón Inalámbrico" });
    return Page();
}
// Método que se ejecuta cuando se envía el formulario con una solicitud POST
public async Task<IActionResult> OnPostAsync()
{
   
       return null;
   }


}}