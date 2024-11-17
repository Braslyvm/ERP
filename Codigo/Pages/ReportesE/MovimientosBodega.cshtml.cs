using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Data;
using System.Globalization;
using System;


namespace proyecto1bases.Pages
{
    public class MovimientosBodegaModel : PageModel {
        private readonly string _connectionString;
        public List<(string bodega, string nombre_bodega, int cantidad_movimientos)> contarMovimientos { get; set; } = new List<(string, string,int)>();
        public string tipo { get; set; }
        public string fechaFin{ get; set; }
        public string fechainicio{ get; set; }

    

        public MovimientosBodegaModel(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        /// OnGetAsync
        /// 
        /// Envia los datos a la interfaz
        /// <returns>La pagina</returns>

        public async Task<IActionResult> OnGetAsync(){
            return Page();
        }
        /// <OnPostAsync>
        /// 
        /// Recibe los datos solicitados de la intefaz 
        /// 
        /// 
        public async Task<IActionResult> OnPostAsync(){
            tipo = Request.Form["tipoMovimiento"];
            fechainicio = Request.Form["fechaInicio"];
            fechaFin = Request.Form["fechaFinal"];
            contarMovimientos = getCantidad(tipo, fechainicio, fechaFin);

            return Page();
        }

            /// <summary>
              ///  Almacena los datos de la tabla en caso de recibir parametros de fecha se filtra
              /// </summary>
              /// <param name="movimiento"></param>
              /// <param name="fechainicio"></param>
              /// <param name="fechafin"></param>
              /// <returns></returns>
              public List<(string bodega, string nombre_bodega, int cantidad_movimientos)> getCantidad(string movimiento, string? fechainicio, string? fechafin)
        {
            var movimientos = new List<(string, string, int)>();
            

            using (var conexion = new SqlConnection(_connectionString)){
                conexion.Open();

                using (var comando = new SqlCommand("SELECT * FROM gestion_inventario.total_movimientos(@tipo_movimiento, @fecha_inicio, @fecha_final)", conexion)){
                    comando.Parameters.AddWithValue("@tipo_movimiento", movimiento);
                    if (fechainicio == "")
                        comando.Parameters.AddWithValue("@fecha_inicio",DBNull.Value);
                    else
                        comando.Parameters.AddWithValue("@fecha_inicio", fechainicio);

                    if (fechafin == "")
                        comando.Parameters.AddWithValue("@fecha_final", DBNull.Value);
                    else
                        comando.Parameters.AddWithValue("@fecha_final", fechafin);

                    using (var reader = comando.ExecuteReader()){
                        while (reader.Read())
                        {
                            string bodega = reader["c_bodega"].ToString();
                            string nombreBodega = reader["nombre_bodega"].ToString();
                            int cantidadMovimientos = Convert.ToInt32(reader["cantidad_movimientos"]);
                            movimientos.Add((bodega, nombreBodega, cantidadMovimientos));
                        }
                    }
                }
            }

            return movimientos;
        }

    }
}
