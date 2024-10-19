using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Threading.Tasks;

/*PARA EL BACK DEBEMOS LLAMAR A gestion_inventario.bodegas_familias Y MOSTRAR UNICAMENTE LOS PRODUCTOS VALIDOS A MOVER, EN CASO DE NO PODER
TIENE QUE EDITAR LA BODEGA Y METERTE TOLERACIA A LA FAMILIA*/

namespace proyecto1bases.Pages
{
    public class MoverInventario : PageModel
    {
        [BindProperty]
        public DateTime Fecha { get; set; }

        [BindProperty]
        public string BodegaOrigen { get; set; }
        [BindProperty]
        public string BodegaDestino { get; set; }

        [BindProperty]
        public List<string> ArticulosSeleccionados { get; set; } = new List<string>();

        public Dictionary<string, int> CantidadesArticulos { get; set; } = new Dictionary<string, int>();

        public List<Bodega> bodegas { get; set; } = new List<Bodega>();
        public List<Articulo> articulos { get; set; } = new List<Articulo>();

        private readonly string _connectionString;

        public MoverInventario(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            
                        bodegas = new List<Bodega>();
                    articulos = new List<Articulo>();
                 bodegas = new List<Bodega>();
          
          
          
          
          

            // Llenado de datos falsos para artículos
            articulos = new List<Articulo>
            {
                new Articulo { c_articulo = "A001", nombreA = "Producto A" },
                new Articulo { c_articulo = "A002", nombreA = "Producto B" },
                new Articulo { c_articulo = "A003", nombreA = "Producto C" }
            };

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            foreach (var articuloId in ArticulosSeleccionados)
            {
                var cantidadInput = Request.Form[$"Cantidad_{articuloId}"];
                if (int.TryParse(cantidadInput, out int cantidad))
                {
                    CantidadesArticulos[articuloId] = cantidad;
                }
            }

            

            return RedirectToPage("SuccessPage"); 
        }
    }
}
