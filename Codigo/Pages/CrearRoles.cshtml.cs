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
public class CrearRoles : PageModel{

 [BindProperty]
 public string NombreRol { get; set; }
[BindProperty]
public bool vendedor { get; set; }
[BindProperty]
public bool edición { get; set; }
[BindProperty]
public bool visualización { get; set; }
[BindProperty]
public bool reportería { get; set; }


 
private readonly string _connectionString;

public CrearRoles(IConfiguration configuration)
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
    using (var connection = new SqlConnection(_connectionString)){
    var command = new SqlCommand(
        "INSERT INTO usuarios.roles (nombre, vendedor, edición, visualización, reportería) VALUES (@NombreRol, @vendedor, @edicion, @visualizacion, @reporteria)", connection);
      
          command.Parameters.AddWithValue("@NombreRol", NombreRol);
          command.Parameters.AddWithValue("@vendedor", vendedor);
         command.Parameters.AddWithValue("@edición", edición);
        command.Parameters.AddWithValue("@visualización", visualización);
        command.Parameters.AddWithValue("@reportería", reportería);
 
  connection.Open();
  await command.ExecuteNonQueryAsync();
  
   return RedirectToPage();
    
 }
    
   


}}}