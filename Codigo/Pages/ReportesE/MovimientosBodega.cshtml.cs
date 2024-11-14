using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace proyecto1bases.Pages.ReportesE
{
    public class MovimientosBodegaModel : PageModel
    {
        private readonly string _connectionString;

        public string? TipoMovimiento { get; set; }
        public List<MovimientoData> Movimientos { get; set; } = new List<MovimientoData>();

        public MovimientosBodegaModel(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task OnGetAsync(string tipoMovimiento)
        {
            TipoMovimiento = tipoMovimiento; // Captura el filtro de tipo de movimiento

            // Llama a la función para obtener los movimientos filtrados según el tipo
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                using (var command = new SqlCommand("SELECT * FROM gestion_inventario.cantidadmovimientos()", connection))
                {
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
