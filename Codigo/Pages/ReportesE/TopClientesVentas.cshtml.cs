using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using System;

namespace proyecto1bases.Pages
{
    public class topClientes : PageModel
    {
        private readonly string _connectionString;
        public List<(string cliente, decimal Monto)> topCliente { get; set; } = new List<(string, decimal)>();

        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }

        public topClientes(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync(DateTime? fechaInicio, DateTime? fechaFin)
        {
            FechaInicio = fechaInicio;
            FechaFin = fechaFin;

            // Llamar a la función con las fechas proporcionadas
            topCliente = GetClientes(FechaInicio, FechaFin);
            return Page();
        }
          /// <summary>
          /// Lee la informacion de la tabla y ALAMACENA EN UNA lista tomando el top 
          /// </summary>
          /// <returns></returns>
        public List<(string cliente, decimal Monto)> GetClientes(DateTime? fechaInicio, DateTime? fechaFin)
        {
            var topCLI = new List<(string, decimal)>();

            using (var conexion = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SELECT nombre_cliente, monto FROM dbo.top_clientes(@fecha_inicio, @fecha_fin)", conexion);

                // Asignar valores a los parámetros de fecha
                command.Parameters.AddWithValue("@fecha_inicio", (object)fechaInicio ?? DBNull.Value);
                command.Parameters.AddWithValue("@fecha_fin", (object)fechaFin ?? DBNull.Value);

                conexion.Open();
                using (var leer = command.ExecuteReader())
                {
                    while (leer.Read())
                    {
                        var cliente = leer.GetString(0);
                      var monto = (decimal)leer.GetInt32(1);
                        topCLI.Add((cliente, monto));
                    }
                }
            }
            return topCLI;
        }
    }
}
