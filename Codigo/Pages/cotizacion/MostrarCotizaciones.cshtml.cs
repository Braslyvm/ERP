using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace proyecto1bases.Pages
{
    public class MostrarCotizaciones : PageModel
    {
        private readonly string connectionString; // Define tu cadena de conexión aquí

        public List<CotizacionConArticulos> Cotizaciones { get; set; }

        public MostrarCotizaciones(IConfiguration configuration){
            connectionString = configuration.GetConnectionString("DefaultConnection");

        }

        public async Task OnGetAsync()
        {
            Cotizaciones = await ObtenerCotizacionesConArticulosYTareas();
        }

        private async Task<List<CotizacionConArticulos>> ObtenerCotizacionesConArticulosYTareas()
        {
            var cotizaciones = new List<CotizacionConArticulos>();

            using (var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("cotizaciones.sp_obtener_cotizaciones_con_articulos", connection))
                {
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            var cotizacion = new CotizacionConArticulos
                            {
                                IdCotizacion = reader.GetInt32(0), // id_cotizacion
                                Cliente = reader.GetInt32(1), // cliente
                                Empleado = reader.GetInt32(2), // empleado
                                FechaCotizacion = reader.GetDateTime(3), // fecha_corizacion
                                MCierre = reader.GetString(4), // m_cierre
                                Probabilidad = reader.GetInt32(5), // probabilidad
                                Tipo = reader.GetString(6), // tipo
                                Descripcion = reader.GetString(7), // descripción
                                Zona = reader.GetString(8), // zona
                                Sector = reader.GetString(9), // sector
                                Estado = reader.GetString(10), // estado
                                MDenegacion = reader.IsDBNull(11) ? null : reader.GetString(11), // m_denegacion
                                ContraQuien = reader.IsDBNull(12) ? null : reader.GetString(12), // contra_quien
                                MontoTotal = reader.IsDBNull(13) ? (int?)null : reader.GetInt32(13), // monto_total
                                Articulos = new List<Articulo>()
                            };

                            if (!reader.IsDBNull(14)) 
                            {
                                cotizacion.Articulos.Add(new Articulo
                                {
                                    CBodega = reader.GetString(14), 
                                    CProducto = reader.GetString(15), 
                                    Cantidad = reader.GetInt32(16), 
                                    Monto = reader.GetInt32(17) 
                                });
                            }

                            cotizaciones.Add(cotizacion);
                        }
                    }
                }
            }

            return cotizaciones;
        }
    }

    public class CotizacionConArticulos
    {
        public int IdCotizacion { get; set; }
        public int Cliente { get; set; }
        public int Empleado { get; set; }
        public DateTime FechaCotizacion { get; set; }
        public string MCierre { get; set; }
        public int Probabilidad { get; set; }
        public string Tipo { get; set; }
        public string Descripcion { get; set; }
        public string Zona { get; set; }
        public string Sector { get; set; }
        public string Estado { get; set; }
        public string MDenegacion { get; set; }
        public string ContraQuien { get; set; }
        public int? MontoTotal { get; set; } // Puede ser nulo
        public List<Articulo> Articulos { get; set; }
    }

    public class Articulo
    {
        public string CBodega { get; set; }
        public string CProducto { get; set; }
        public int Cantidad { get; set; }
        public int Monto { get; set; }
    }
}
