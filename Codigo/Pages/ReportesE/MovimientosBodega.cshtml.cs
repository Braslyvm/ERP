using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace proyecto1bases.Pages.ReportesE
{
    public class MovimientosBodegaModel : PageModel
    {
        private readonly string _connectionString;

        public string? TipoMovimiento { get; set; }
        public List<MovimientoData> Movimientos { get; set; } = new List<MovimientoData>();
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }

        public MovimientosBodegaModel(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
          /// <summary>
          /// Lee la informacion de la tabla y la retorna a la clase del tipo de la tabla 
          /// </summary>
          /// <returns></returns>
        public async Task OnGetAsync(string? tipoMovimiento, DateTime? fechaInicio, DateTime? fechaFin)
        {
            TipoMovimiento = tipoMovimiento; // Captura el filtro de tipo de movimiento
            FechaInicio = fechaInicio; // Captura la fecha de inicio
            FechaFin = fechaFin; // Captura la fecha de fin

            // Llama a la función para obtener los movimientos filtrados según el tipo y las fechas
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM gestion_inventario.cantidadmovimientos(@fecha_inicio, @fecha_fin)", connection))
                {
                    command.Parameters.AddWithValue("@fecha_inicio", FechaInicio ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@fecha_fin", FechaFin ?? (object)DBNull.Value);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            string tipo = reader["tipo"].ToString();
                            if (TipoMovimiento == null || TipoMovimiento == tipo)
                            {
                                Movimientos.Add(new MovimientoData
                                {
                                    Bodega = reader["bodega"].ToString(),
                                    Tipo = tipo,
                                    Cantidad = int.Parse(reader["cantidad_casos"].ToString())
                                });
                            }
                        }
                    }
                }
            }
        }
    }

    public class MovimientoData
    {
        public string Bodega { get; set; }
        public string Tipo { get; set; }
        public int Cantidad { get; set; }
    }
}
