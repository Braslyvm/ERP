using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;

namespace proyecto1bases.Pages
{
    public class Cproductos : PageModel
    {
        public List<(string codigo, string producto, string bodega, int cantidad)> productos { get; set; } = new List<(string, string, string, int)>();
        
        public List<(string Codigo, string Bodega, int Cantidad)> ProductosSeleccionados { get; set; } = new List<(string, string, int)>();


        public int IdCotizacion { get; set; }
        public List<int> Cotizacion { get; set; } = new List<int>();

        private readonly string _connectionString;

        public Cproductos(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync(bool? success)
        {
            productos = GetProductos();
            Cotizacion = GetCotizacion();
            return Page();
        }
        public async Task<IActionResult> OnPostAgregarAsync(string[] seleccionados, Dictionary<string, int> cantidades, Dictionary<string, string> bodegas)
        {
            if (seleccionados != null)
            {
                foreach (var codigo in seleccionados)
                {
                    if (cantidades.TryGetValue(codigo, out int cantidad))
                    {
                        if (bodegas.TryGetValue(codigo, out string bodega)){
                            ProductosSeleccionados.Add((codigo, bodega, cantidad)); 
                        }
                        else
                        {
                            Console.WriteLine($"No se encontró la bodega para el código: {codigo}");
                        }
                    }
                }
            }
            IdCotizacion = int.Parse(Request.Form["IdCotizacion"]);
            foreach (var producto in ProductosSeleccionados){
                var mensaje = await InsertarArticuloCotizacion(IdCotizacion, producto.Codigo, producto.Cantidad, producto.Bodega);
            }

            total (IdCotizacion);
            TempData["Mensaje"] = "Productos agregados correctamente.";

            ProductosSeleccionados.Clear();

            return RedirectToPage(); 
        }
        public List<(string, string, string, int)> GetProductos()
        {
            var producto = new List<(string, string, string, int)>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SELECT codigo, nombre, bodega, cantidad FROM dbo.Articulos()", conexion);
                conexion.Open();
                using (var leer = command.ExecuteReader()){
                    while (leer.Read())
                    {
                        var codigo = leer.GetString(0);
                        var nombre = leer.GetString(1);
                        var bodega = leer.GetString(2);
                        var cantidad = leer.GetInt32(3);
                        producto.Add((codigo, nombre, bodega, cantidad));
                    }
                }
            }
            return producto;
        }
        public List<int> GetCotizacion()
        {
            var cotizaciones = new List<int>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SELECT id_cotizacion FROM dbo.cotizaciones()", conexion);
                conexion.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var id_cotizacion = reader.GetInt32(0);
                        cotizaciones.Add(id_cotizacion);
                    }
                }
            }
            return cotizaciones;
        }
        private async Task<string> InsertarArticuloCotizacion(int idCotizacion, string codigoProducto, int cantidad, string bodega){
            string mensajeSalida = string.Empty;
            using (var conexion = new SqlConnection(_connectionString)){
                await conexion.OpenAsync();
                var command = new SqlCommand("cotizaciones.insertar_articulo_cotizacion", conexion);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@id_cotizacion", idCotizacion);
                command.Parameters.AddWithValue("@c_producto", codigoProducto);
                command.Parameters.AddWithValue("@cantidad", cantidad);
                command.Parameters.AddWithValue("@c_Bodega", bodega);
                var mensajeParametro = new SqlParameter("@mensaje", System.Data.SqlDbType.NVarChar, 200){
                    Direction = System.Data.ParameterDirection.Output
                };
                command.Parameters.Add(mensajeParametro);
                await command.ExecuteNonQueryAsync();
                mensajeSalida = (string)mensajeParametro.Value;
            }
            return mensajeSalida;
        }
        public async Task total (int id_cotizacion){
            using (var conexion = new SqlConnection(_connectionString)){
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC cotizaciones.actualizar_monto_total_cotizacion @id_cotizacion ", conexion);
                comando.Parameters.AddWithValue("@id_cotizacion", id_cotizacion);
                await comando.ExecuteNonQueryAsync();

                
            }
        }  
    }
}
