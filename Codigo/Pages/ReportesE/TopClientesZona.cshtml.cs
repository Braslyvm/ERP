using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using proyecto1bases.Models;

namespace proyecto1bases.Pages
{
    public class topClientesZona : PageModel
    {
        private readonly string _connectionString;
        public List<(string Zona, int cantidad_clientes, int monto_total)> topClientezona { get; set; } = new List<(string, int, int)>();
        [BindProperty(SupportsGet = true)]
        public DateTime? FechaInicio { get; set; }
        [BindProperty(SupportsGet = true)]
        public DateTime? FechaFin { get; set; }

        public topClientesZona(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            topClientezona = GetClientesZona(FechaInicio, FechaFin);
            return Page();
        }
         
         
         
         
        /// <summary>
                /// Muestra el top de clientes por zona
                /// 
                /// </summary>
                /// <param name="fechaInicio"></param>
                /// <param name="fechaFin"></param>
                /// <returns> tabla con el cliene y la zona y ttal</returns>
                public List<(string Zona, int cantidad_clientes, int monto_total)> GetClientesZona(DateTime? fechaInicio, DateTime? fechaFin)
        {
            var clienteZona = new List<(string, int, int)>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SELECT zona, cantidad_clientes, monto_total_ventas FROM dbo.clientes_zona(@fecha_inicio, @fecha_fin)", conexion);
                command.Parameters.AddWithValue("@fecha_inicio", (object)fechaInicio ?? DBNull.Value);
                command.Parameters.AddWithValue("@fecha_fin", (object)fechaFin ?? DBNull.Value);

                conexion.Open();
                using (var leer = command.ExecuteReader())
                {
                    while (leer.Read())
                    {
                        var zona = leer.GetString(0);
                        var cantidad_clientes = leer.GetInt32(1);
                        var monto_total_ventas = leer.GetInt32(2);

                        clienteZona.Add((zona, cantidad_clientes, monto_total_ventas));
                    }
                }
            }
            return clienteZona;
        }
    }
}
