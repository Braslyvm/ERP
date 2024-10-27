using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;

namespace proyecto1bases.Pages
{
    public class opcionescotizacion : PageModel
    {
        private readonly string _connectionString;
        public int Cedula { get; set; }
        public bool CanCotizar { get; set; }
        public bool CanEditarCotizacion { get; set; }
        public bool CanEliminarCotizacion { get; set; }
        public bool CanListaProductos { get; set; }
        public bool CanAsociarTarea { get; set; }
        public bool CanModificarTarea { get; set; }
        public bool CanEliminarTarea { get; set; }
        public bool CanMostrarCotizaciones { get; set; }

        public opcionescotizacion(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            Cedula = configuration.GetSection("Cedulas").Get<int[]>().FirstOrDefault();
        }

        public async Task<IActionResult> OnGetAsync()
        {
            CanCotizar = await ValidarPermiso("edicion");
            CanEditarCotizacion = await ValidarPermiso("edicion");
            CanEliminarCotizacion = await ValidarPermiso( "edicion");
            CanListaProductos = await ValidarPermiso("edicion");
            CanAsociarTarea = await ValidarPermiso( "edicion");
            CanModificarTarea = await ValidarPermiso("edicion");
            CanEliminarTarea = await ValidarPermiso( "edicion");
            CanMostrarCotizaciones = await ValidarPermiso("visualizacion");
            return Page();
        }

        private async Task<bool> ValidarPermiso(string tipo)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT dbo.validar_permiso_cotizacion(@cedula,@tipo)", connection))
                {
                    command.Parameters.AddWithValue("@cedula", Cedula);
                    command.Parameters.AddWithValue("@tipo", tipo);
                    var result = await command.ExecuteScalarAsync();
                    return result != null && (result is int intValue ? intValue == 1 : result is bool boolValue && boolValue);
                }
            }
        }   
    }
}
