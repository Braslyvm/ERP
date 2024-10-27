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
    public class Facturar : PageModel
    {
        [BindProperty] public string CedulaJ { get; set; }
        [BindProperty] public List<string> ArticulosSeleccionados { get; set; } = new List<string>();
        public List<Cliente> Clientes { get; set; } = new List<Cliente>();
        public List<Articulo> Articulos { get; set; } = new List<Articulo>();
        
        private readonly string _connectionString;

        public Facturar(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Cargar Clientes
                string sqlClientes = "SELECT * FROM clientes.ObtenerCliente();";
                using (SqlCommand commandClientes = new SqlCommand(sqlClientes, connection))
                {
                    using (SqlDataReader reader = await commandClientes.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Cliente cliente = new Cliente
                            {
                                CedulaJ = reader.GetInt32(reader.GetOrdinal("cedula")),
                                NombreC = reader.GetString(reader.GetOrdinal("nombre")),
                                CorreoE = reader.IsDBNull(reader.GetOrdinal("Correo_Electronico")) ? null : reader.GetString(reader.GetOrdinal("Correo_Electronico")),
                                Telefono = reader.IsDBNull(reader.GetOrdinal("Telefono")) ? 0 : reader.GetInt32(reader.GetOrdinal("Telefono")),
                                celular = reader.IsDBNull(reader.GetOrdinal("celular")) ? 0 : reader.GetInt32(reader.GetOrdinal("celular")),
                                fax = reader.IsDBNull(reader.GetOrdinal("fax")) ? null : reader.GetString(reader.GetOrdinal("fax")),
                                zona = reader.IsDBNull(reader.GetOrdinal("zona")) ? null : reader.GetString(reader.GetOrdinal("zona")),
                                sector = reader.IsDBNull(reader.GetOrdinal("sector")) ? null : reader.GetString(reader.GetOrdinal("sector")),
                            };
                            Clientes.Add(cliente);
                        }
                    }
                }

                // Cargar Artículos
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
                                Precio = reader.GetInt32(reader.GetOrdinal("precio")), // Cambia a decimal si corresponde
                                c_bodega = reader.GetString(reader.GetOrdinal("c_bodega")),
                                cantidad = reader.GetInt32(reader.GetOrdinal("cantidad")),
                            };
                            if (articulo.Activo)
                            {
                                Articulos.Add(articulo);
                            }
                        }
                    }
                }
            }

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            var articulosSeleccionadosConCantidad = new List<(string ArticuloId, int Cantidad)>();

            foreach (var articuloId in Request.Form["ArticulosSeleccionados"])
            {
                var cantidadInputName = $"Cantidad_{articuloId}";
                var cantidadStr = Request.Form[cantidadInputName];

                if (int.TryParse(cantidadStr, out var cantidad) && cantidad > 0)
                {
                    articulosSeleccionadosConCantidad.Add((articuloId, cantidad));
                }
            }

           
           

            return RedirectToPage("FacturaDetalle", new { clienteId = CedulaJ, articulos = string.Join(",", articulosSeleccionadosConCantidad.Select(a => $"{a.ArticuloId}:{a.Cantidad}")) });
        }
    }
    
}
