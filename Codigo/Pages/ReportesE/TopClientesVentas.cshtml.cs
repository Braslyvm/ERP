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
    public class topClientes : PageModel {
        private readonly string _connectionString;
        public List<(string cliente, int Monto)> topCliente { get; set; } = new List<(string, int)>();

        
        public topClientes(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        
        /// OnGetAsync
        /// 
        /// Envia los datos a la interfaz
        /// <returns>La pagina</returns>
        public async Task<IActionResult> OnGetAsync(){
            topCliente = GetClientes();
            return Page();
        }
        /// <GetClientesZona>
        /// 
        /// Enlista el cliente y el monto
        /// retorna la lista de top 10 clientes topCLI
         public List<(string cliente, int Monto)> GetClientes(){
            var topCLI = new List<(string, int)>();

            using (var conexion = new SqlConnection(_connectionString)){
                var command = new SqlCommand("SELECT nombre_cliente, monto FROM dbo.top_clientes()", conexion);
                conexion.Open();
                using (var leer = command.ExecuteReader()){
                    while (leer.Read()){
                        var cliente = leer.GetString(0);  
                        var noMontombre = leer.GetInt32(1);    
                        topCLI.Add((cliente, noMontombre));
                    }
                }
            }
            return topCLI;
        }
    }
}
