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
  
// Página de modelo para la gestión de planillas
public class CrearZona : PageModel{

 [BindProperty]
 public string NombreZ { get; set; }

 
private readonly string _connectionString;

public CrearZona(IConfiguration configuration)
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
       "INSERT INTO clientes.zona(zona_nombre) VALUES (@NombreZ)",connection);
       
   command.Parameters.AddWithValue("@NombreZ", NombreZ);
  
   connection.Open();
   await command.ExecuteNonQueryAsync();
}
 
          return RedirectToPage();
   }


}}