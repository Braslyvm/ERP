using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    public class Facturar : PageModel
    {
        [BindProperty]
        public string NombreC { get; set; }

        [BindProperty]
        public string CedulaJ { get; set; }

        [BindProperty]
        public int CotizacionC { get; set; }

        [BindProperty]
        public List<string> ArticulosSeleccionados { get; set; } = new List<string>();

        public Dictionary<string, int> CantidadesArticulos { get; set; } = new Dictionary<string, int>();
        public List<Cliente> Clientes { get; set; } = new List<Cliente>();
        public List<Empleado> Empleados { get; set; } = new List<Empleado>();
        public List<Bodega> Bodegas { get; set; } = new List<Bodega>();
        public List<Articulo> Articulos { get; set; } = new List<Articulo>();

        private readonly string _connectionString;

        public Facturar(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            // Datos de prueba
            Clientes.Add(new Cliente { NombreC = "Juan Pérez", CedulaJ = "30123456789" });
            Bodegas.Add(new Bodega { C_Bodega = 1, NombreB = "Bodega A" });
            Bodegas.Add(new Bodega { C_Bodega = 2, NombreB = "Bodega B" });

            Articulos.Add(new Articulo { c_articulo = "1", nombreA = "Monitor 24\"" });
            Articulos.Add(new Articulo { c_articulo = "2", nombreA = "Teclado Mecánico" });
            Articulos.Add(new Articulo { c_articulo = "3", nombreA = "Ratón Inalámbrico" });

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {


            // Redirigir a la página de detalles de la factura aqui hay que cargar las listas de factura detalle con todo lo nesesario
            return RedirectToPage("FacturaDetalle", new { cedula = "00000", articulos = string.Join(",", ArticulosSeleccionados) });//el new manda los datos al siguiente
        }
    }
}
