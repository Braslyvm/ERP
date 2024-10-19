using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace proyecto1bases.Pages
{
  
// Página de modelo para la gestión de planillas
public class CrearSector : PageModel{

 [BindProperty]
 public string NombreSector { get; set; }

 
private readonly string _connectionString;

public CrearSector(IConfiguration configuration)
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
         "INSERT INTO clientes.sector(sector_nombre) VALUES (@NombreSector)",connection);
         
     command.Parameters.AddWithValue("@NombreSector", NombreSector);
    
     connection.Open();
     await command.ExecuteNonQueryAsync();
 }
   
      return RedirectToPage();
   }


}}