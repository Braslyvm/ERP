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
    public class Transados : PageModel {
        private readonly string _connectionString;
        public List<(string bodega, string nombre_bodega, int Entradas , int  Salidas, int total  )> Transadostop { get; set; } = new List<(string, string,int,int,int)>();
        public string fechaFin{ get; set; }
        public string fechainicio{ get; set; }

    

        public Transados(IConfiguration configuration){
            
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        /// OnGetAsync
        /// 
        /// Envia los datos a la interfaz
        /// <returns>La pagina</returns>

        public async Task<IActionResult> OnGetAsync(){
            Transadostop = GetTransados("","");
            return Page();
        }
      
      
      
        
    
            /// <summary>
                        /// recibe y fltra los productos mas transados 
                        /// </summary>
                        /// <returns>tabla con las entradas salidas y total</returns>
                        public async Task<IActionResult> OnPostAsync(){
            fechainicio = Request.Form["fechaInicio"];
            fechaFin = Request.Form["fechaFinal"];
            Transadostop = GetTransados( fechainicio, fechaFin);

            return Page();
        }

        public List<(string bodega, string nombre_bodega, int Entradas , int  Salidas, int total )> GetTransados( string? fechainicio, string? fechafin)
        {
            var Transado = new List<(string, string,int,int,int)>();
            

            using (var conexion = new SqlConnection(_connectionString)){
                conexion.Open();

                using (var comando = new SqlCommand("SELECT * FROM dbo.top_transados (@fecha_inicio, @fecha_final)", conexion)){
                    if (fechainicio == "") {
                        comando.Parameters.AddWithValue("@fecha_inicio",DBNull.Value);
                        comando.Parameters.AddWithValue("@fecha_final", DBNull.Value);
                    }
                    else {
                        if (fechafin == ""){
                            comando.Parameters.AddWithValue("@fecha_inicio",DBNull.Value);
                            comando.Parameters.AddWithValue("@fecha_final", DBNull.Value);
                        }
                        else {
                            comando.Parameters.AddWithValue("@fecha_inicio", fechainicio);
                            comando.Parameters.AddWithValue("@fecha_final", fechafin);
                        }
                    }
                    using (var reader = comando.ExecuteReader()){
                        while (reader.Read()){
                            string bodega = reader["c_bodega"].ToString();
                            string nombreBodega = reader["nombre_bodega"].ToString();
                            int entradas = Convert.ToInt32(reader["Entrada"]);
                            int salidas = Convert.ToInt32(reader["Salida"]);
                            int total = Convert.ToInt32(reader["total_transacciones"]);
                            Transado.Add((bodega, nombreBodega, entradas,salidas,total));
                        }
                    }
                }
            }

            return Transado;
        }

    }
}
