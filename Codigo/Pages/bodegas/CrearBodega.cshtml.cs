using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
//using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages
{
  

public class RegistroBodega : PageModel{

 [BindProperty]
 public string c_bodega { get; set; }
[BindProperty]
public string nombre { get; set; }
[BindProperty]
public string ubicacion { get; set; }
[BindProperty]
public int c_toneladas { get; set; }
[BindProperty]
public int e_cubico { get; set; }


 
private readonly string _connectionString;

public RegistroBodega(IConfiguration configuration)
{
    _connectionString = configuration.GetConnectionString("DefaultConnection");
}
public async Task<IActionResult> OnGetAsync()
{
   
   
    return Page();
}

public async Task<IActionResult> OnPostAsync()
{
   using (var connection = new SqlConnection(_connectionString))
{
    var command = new SqlCommand(
        "INSERT INTO gestion_inventario.bodegas(c_bodega,nombre,ubicacion,c_toneladas,e_cubico ) VALUES (@c_bodega,@nombre,@ubicacion,@c_toneladas,@e_cubico )",connection);
        
    command.Parameters.AddWithValue("@c_bodega", c_bodega);
    command.Parameters.AddWithValue("@nombre", nombre);
    command.Parameters.AddWithValue("@ubicacion", ubicacion);
    command.Parameters.AddWithValue("@c_toneladas", c_toneladas);
    command.Parameters.AddWithValue("@e_cubico", e_cubico);

   
    connection.Open();
    await command.ExecuteNonQueryAsync();
}
  
     return RedirectToPage();
      
   }


}}