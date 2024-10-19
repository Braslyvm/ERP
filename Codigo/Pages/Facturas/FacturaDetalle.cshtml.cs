using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Collections.Generic;

namespace proyecto1bases.Pages
{
    public class FacturaDetalle : PageModel
    {
        public string Cedula { get; set; }
        public List<string> Articulos { get; set; } = new List<string>();

        public void OnGet(string cedula, string articulos)
        {
            Cedula = cedula;
            Articulos = articulos?.Split(',').ToList();
        }
    }
}
