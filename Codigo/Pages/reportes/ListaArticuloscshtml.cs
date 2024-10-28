using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    public class ListaArticulos : PageModel
    {
        public List<Articulo> Articulos { get; set; } = new List<Articulo>();
        
        private readonly string _connectionString;

        public ListaArticulos(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    // Cargar Artículos desde la función gestion_inventario.productos()
                   string sqlArticulos = "SELECT * FROM gestion_inventario.productos();";

                    using (SqlCommand commandArticulos = new SqlCommand(sqlArticulos, connection))
                    {
                        using (SqlDataReader reader = await commandArticulos.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                Articulo articulo = new Articulo
                                {
                                    c_articulo = reader.GetString(reader.GetOrdinal("c_articulo")),
                                    nombreA = reader.GetString(reader.GetOrdinal("nombre")),
                                    Activo = reader.GetBoolean(reader.GetOrdinal("activo")),
                                    Descripcion = reader.GetString(reader.GetOrdinal("descripcion")),
                                    CFamilia = reader.GetString(reader.GetOrdinal("c_familia")),
                                    Peso = reader.GetInt32(reader.GetOrdinal("peso")),
                                    Precio = reader.GetInt32(reader.GetOrdinal("precio")), 
                                    c_bodega = reader.GetString(reader.GetOrdinal("c_bodega")),
                                    cantidad = reader.GetInt32(reader.GetOrdinal("cantidad")),
                                };
                                Articulos.Add(articulo);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejo de excepciones
                return Content($"Error: {ex.Message}");
            }

            return Page();
        }
    }
}
