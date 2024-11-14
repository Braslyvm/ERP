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
    public class topClientesZona : PageModel {
        private readonly string _connectionString;
        public List<(string Zona, int cantidad_clientes, int monto_total)> topClientezona { get; set; } = new List<(string, int,int)>();


        public topClientesZona(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        /// OnGetAsync
        /// 
        /// Envia los datos a la interfaz
        /// <returns>La pagina</returns>

        public async Task<IActionResult> OnGetAsync(){
            topClientezona = GetClientesZona();
            return Page();
        }
        /// <GetClientesZona>
        /// 
        /// Enlista la zona , la cantidad de clientes , el monto total
        /// retorna la lista de los clientes por zona clienteZona

         public List<(string Zona, int cantidad_clientes, int monto_total)> GetClientesZona(){
            var clienteZona = new List<(string, int,int)>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT zona, cantidad_clientes,monto_total_ventas FROM  dbo.clientes_zona()", conexion);
                conexion.Open();
                using (var leer = command.ExecuteReader()){
                    while (leer.Read()){
                        var zona = leer.GetString(0);  
                        var cantidad_clientes = leer.GetInt32(1);
                        var monto_total_ventas = leer.GetInt32(2);  

                        clienteZona.Add((zona, cantidad_clientes,monto_total_ventas));
                    }
                }
            }
            return clienteZona;
        }
    }
}
