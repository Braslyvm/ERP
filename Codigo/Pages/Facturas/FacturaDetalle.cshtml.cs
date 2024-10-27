using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    public class FacturaDetalle : PageModel
    {
        public Cliente Cliente { get; set; }
        [BindProperty] 
        public int CedulaJ { get; set; }
        public List<Articulo> Articulos { get; set; } = new List<Articulo>();
        public List<Local> Locales { get; set; } = new List<Local>(); 
        public List<Empleado> Empleados { get; set; } = new List<Empleado>();
        public int EmpleadoSeleccionado { get; set; }
        public decimal Total { get; set; } // Cambiado a decimal para mejor precisión en el total
        public string SuccessMessage { get; set; }

        private readonly string _connectionString;
        private readonly ILogger<FacturaDetalle> _logger;
        public List<Cliente> Clientes { get; set; } = new List<Cliente>();

        public FacturaDetalle(IConfiguration configuration, ILogger<FacturaDetalle> logger)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            _logger = logger;
        }

        public async Task<IActionResult> OnGetAsync(string clienteId, string articulos)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Obtener información del cliente
                string sqlCliente = "SELECT * FROM clientes.obtenerclientoporcedula(@cedula);";
                using (SqlCommand commandCliente = new SqlCommand(sqlCliente, connection))
                {
                    commandCliente.Parameters.AddWithValue("@cedula", clienteId);
                    using (SqlDataReader reader = await commandCliente.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            Cliente = new Cliente
                            {
                                CedulaJ = reader.GetInt32(reader.GetOrdinal("cedula")),
                                NombreC = reader.GetString(reader.GetOrdinal("nombre")),
                                CorreoE = reader.GetString(reader.GetOrdinal("Correo_Electronico")),
                                Telefono = reader.GetInt32(reader.GetOrdinal("Telefono")),
                                celular = reader.GetInt32(reader.GetOrdinal("celular")),
                                fax = reader.GetString(reader.GetOrdinal("fax")),
                                zona = reader.GetString(reader.GetOrdinal("zona")),
                                sector = reader.GetString(reader.GetOrdinal("sector")),
                            };
                        }
                    }
                }

                // Obtener artículos facturados
                var articulosSeleccionados = articulos.Split(',');
                foreach (var articulo in articulosSeleccionados)
                {
                    var partes = articulo.Split(':');
                    var articuloId = partes[0];
                    var cantidad = int.Parse(partes[1]);

                    string sqlArticulo = "SELECT * FROM gestion_inventario.productos() WHERE c_articulo = @articuloId;";
                    using (SqlCommand commandArticulo = new SqlCommand(sqlArticulo, connection))
                    {
                        commandArticulo.Parameters.AddWithValue("@articuloId", articuloId);
                        using (SqlDataReader reader = await commandArticulo.ExecuteReaderAsync())
                        {
                            if (await reader.ReadAsync())
                            {
                                Articulo item = new Articulo
                                {
                                    c_articulo = reader.GetString(reader.GetOrdinal("c_articulo")),
                                    nombreA = reader.GetString(reader.GetOrdinal("nombre")),
                                    Precio = reader.GetInt32(reader.GetOrdinal("precio")),
                                    cantidad = cantidad
                                };
                                Total += item.Precio * cantidad;
                                Articulos.Add(item);
                            }
                        }
                    }
                }

                // Obtener información del local
                string sqlLocal = "SELECT * FROM facturación.ERP();";
                using (SqlCommand commandLocal = new SqlCommand(sqlLocal, connection))
                {
                    using (SqlDataReader reader = await commandLocal.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Local local = new Local
                            {
                                nombre_local = reader.GetString(reader.GetOrdinal("nombre_local")),
                                cedula_juridica_local = reader.GetInt32(reader.GetOrdinal("cedula_juridica_local")),
                                telefono_local = reader.GetInt32(reader.GetOrdinal("telefono_local"))
                            };
                            Locales.Add(local);
                            CedulaJ = local.cedula_juridica_local;
                        }
                    }
                }

                // Obtener lista de empleados
                string sqlEmpleados = "SELECT cedula, nombre, apellido1 FROM usuarios.ObtenerEmpleados();";
                using (SqlCommand commandEmpleados = new SqlCommand(sqlEmpleados, connection))
                {
                    using (SqlDataReader reader = await commandEmpleados.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Empleado empleado = new Empleado
                            {
                                Cedula = reader.GetInt32(reader.GetOrdinal("cedula")),
                                Nombre = reader.GetString(reader.GetOrdinal("nombre")),
                                Apellido1 = reader.GetString(reader.GetOrdinal("apellido1"))
                            };
                            Empleados.Add(empleado);
                        }
                    }
                }
            }

            return Page();
        }

        private async Task<List<Articulo>> CargarArticulosAsync(SqlConnection connection)
        {
            List<Articulo> articulos = new List<Articulo>();
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
                            articulos.Add(articulo);
                        }
                    }
                }
            }

            return articulos;
        }

        public async Task<IActionResult> OnPostAsync(string clienteId, string articulos, int empleadoSeleccionado)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                // Llamar a la función para cargar artículos
                Articulos = await CargarArticulosAsync(connection);
                EmpleadoSeleccionado = empleadoSeleccionado;

                // Volver a consultar la cédula jurídica del local
                string sqlLocal = "SELECT * FROM facturación.ERP();";
                using (SqlCommand commandLocal = new SqlCommand(sqlLocal, connection))
                {
                    using (SqlDataReader reader = await commandLocal.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            CedulaJ = reader.GetInt32(reader.GetOrdinal("cedula_juridica_local"));
                        }
                    }
                }

                // Insertar la factura
                using (SqlCommand command = new SqlCommand("facturación.insertar_Factura", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Agregar parámetros
                    command.Parameters.AddWithValue("@cedula_juridica_local", CedulaJ);
                    command.Parameters.AddWithValue("@id_cliente", clienteId);
                    command.Parameters.AddWithValue("@id_cotizacion", DBNull.Value);
                    command.Parameters.AddWithValue("@id_empleado", empleadoSeleccionado);
                    command.Parameters.AddWithValue("@fecha_factura", DateTime.Now);
                    command.Parameters.AddWithValue("@estado", "aprobada");
                    command.Parameters.AddWithValue("@motivo_anulacion", DBNull.Value);
                    command.Parameters.AddWithValue("@Total", Total);

                    // Configurar parámetro de salida para el mensaje
                    SqlParameter mensajeParameter = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(mensajeParameter);

                    // Ejecutar el procedimiento
                    await command.ExecuteNonQueryAsync();
                    
                    // Obtener y mostrar el mensaje de salida
                    string mensaje = mensajeParameter.Value?.ToString() ?? "Mensaje no disponible";
                    _logger.LogInformation(mensaje);
                    SuccessMessage = mensaje;
                }

                // Insertar cada artículo en la factura
                var articulosSeleccionados = articulos.Split(',');
                foreach (var articulo in articulosSeleccionados)
                {
                    var partes = articulo.Split(':');
                    var articuloId = partes[0];
                    var cantidad = int.Parse(partes[1]);
                    var precioUnitario = Articulos.First(a => a.c_articulo == articuloId).Precio; // Obtener el precio del artículo
                    var montoTotal = precioUnitario * cantidad; // Calcular el monto total por artículo
                    var bodega = Articulos.First(a => a.c_articulo == articuloId);
                     
                     
                    string mensajeSalida;

                    //Llamar al procedimiento LineasFactura
                    using (SqlCommand commandLinea = new SqlCommand("facturación.LineasFactura", connection))
                    {
                        commandLinea.CommandType = CommandType.StoredProcedure;
                        // Agregar parámetros
                        commandLinea.Parameters.AddWithValue("@c_articulo", articuloId);
                        commandLinea.Parameters.AddWithValue("@cantidad", cantidad);
                        commandLinea.Parameters.AddWithValue("@monto_total", montoTotal);
                        commandLinea.Parameters.AddWithValue("@precio_unitario", precioUnitario); 
                         commandLinea.Parameters.AddWithValue("@usuario",EmpleadoSeleccionado );
                          

                        // Configurar parámetro de salida para el mensaje
                        SqlParameter mensajeParameterLinea = new SqlParameter("@mensaje", SqlDbType.NVarChar, 200)
                        {
                            Direction = ParameterDirection.Output
                        };
                        commandLinea.Parameters.Add(mensajeParameterLinea);

                        // Ejecutar el procedimiento
                        await commandLinea.ExecuteNonQueryAsync();
                        mensajeSalida = mensajeParameterLinea.Value?.ToString() ?? "Mensaje no disponible";
                        _logger.LogInformation(mensajeSalida);
                    }
                }
            }

            return RedirectToPage("Facturas"); 
        }
    }
}
