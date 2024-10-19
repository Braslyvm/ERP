using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using proyecto1bases.Models;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    public class IngresoInventario : PageModel
    {
        [BindProperty]
        public DateTime Fecha { get; set; }

        [BindProperty]
        public string BodegaSeleccionada { get; set; }

        [BindProperty]
        public List<string> ArticulosSeleccionados { get; set; } = new List<string>();

        public Dictionary<string, int> CantidadesArticulos { get; set; } = new Dictionary<string, int>();

        public List<Bodega> bodegas { get; set; } = new List<Bodega>();
        public List<Articulo> articulos { get; set; } = new List<Articulo>();

        private readonly string _connectionString;

        public IngresoInventario(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IActionResult> OnGetAsync()
        {
            
                        bodegas = new List<Bodega>();
                    articulos = new List<Articulo>();
                

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
