using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Threading.Tasks;

namespace proyecto1bases.Pages
{
    public class CrearRoles : PageModel
    {
        public string NombreRol { get; set; }
        public bool PVenta { get; set; }
        public bool EInventario { get; set; }
        public bool VInventario { get; set; }
        public bool RInventario { get; set; }
        public bool EUsuarios { get; set; }
        public bool VUsuarios { get; set; }
        public bool RUsuarios { get; set; }
        public bool ECotizacion { get; set; }
        public bool VCotizacion { get; set; }
        public bool RCotizacion { get; set; }
        public bool EFactura { get; set; }
        public bool VFactura { get; set; }
        public bool RFactura { get; set; }
        public bool ECliente { get; set; }
        public bool VCliente { get; set; }
        public bool RCliente { get; set; }
        public bool EReporte { get; set; }
        public bool VReporte { get; set; }
        public bool RReporte { get; set; }
        public bool ECasos { get; set; }
        public bool VCasos { get; set; }
        public bool RCasos { get; set; }
        public bool roltrue { get; set; } = false;

        private readonly string _connectionString;

        public CrearRoles(IConfiguration configuration) {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public async Task<IActionResult> OnPostAsync() {

            NombreRol = Request.Form["NombreRol"];
            PVenta = Convert.ToBoolean(Request.Form["PVenta"]);
            EInventario = Convert.ToBoolean(Request.Form["EInventario"]);
            VInventario = Convert.ToBoolean(Request.Form["VInventario"]);
            RInventario = Convert.ToBoolean(Request.Form["RInventario"]);
            EUsuarios = Convert.ToBoolean(Request.Form["EUsuarios"]);
            VUsuarios = Convert.ToBoolean(Request.Form["VUsuarios"]);
            RUsuarios = Convert.ToBoolean(Request.Form["RUsuarios"]);
            ECotizacion = Convert.ToBoolean(Request.Form["ECotizacion"]);
            VCotizacion = Convert.ToBoolean(Request.Form["VCotizacion"]);
            RCotizacion = Convert.ToBoolean(Request.Form["RCotizacion"]);
            EFactura = Convert.ToBoolean(Request.Form["EFactura"]);
            VFactura = Convert.ToBoolean(Request.Form["VFactura"]);
            RFactura = Convert.ToBoolean(Request.Form["RFactura"]);
            ECliente = Convert.ToBoolean(Request.Form["ECliente"]);
            VCliente = Convert.ToBoolean(Request.Form["VCliente"]);
            RCliente = Convert.ToBoolean(Request.Form["RCliente"]);
            EReporte = Convert.ToBoolean(Request.Form["EReporte"]);
            VReporte = Convert.ToBoolean(Request.Form["VReporte"]);
            RReporte = Convert.ToBoolean(Request.Form["RReporte"]);
            ECasos = Convert.ToBoolean(Request.Form["ECasos"]);
            VCasos = Convert.ToBoolean(Request.Form["VCasos"]);
            RCasos = Convert.ToBoolean(Request.Form["RCasos"]);

            if (string.IsNullOrWhiteSpace(NombreRol)) {
                return Page(); 
            }
            await CrearRol(NombreRol, PVenta); 
            await PermisoInventario(NombreRol, EInventario, VInventario, RInventario);
            await PermisoUsuario(NombreRol, EUsuarios, VUsuarios, RUsuarios);
            await PermisoCotizacion(NombreRol, ECotizacion, VCotizacion, RCotizacion);
            await PermisoFactura(NombreRol, EFactura, VFactura, RFactura);
            await PermisoClientes(NombreRol, ECliente, VCliente, RCliente);
            await PermisoReporte(NombreRol, EReporte, VReporte, RReporte);
            await PermisoCaso(NombreRol, ECasos, VCasos, RCasos);
            roltrue = true;
            return Page(); 
    
        }



        public async Task CrearRol(string NombreRol, bool PVenta)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC CrearRol @NombreRol, @PVenta", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@PVenta", PVenta);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoInventario(string NombreRol, bool EInventario, bool VInventario, bool RInventario)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosInventario @NombreRol, @EInventario, @VInventario, @RInventario", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@EInventario", EInventario);
                comando.Parameters.AddWithValue("@VInventario", VInventario);
                comando.Parameters.AddWithValue("@RInventario", RInventario);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoUsuario(string NombreRol, bool EUsuarios, bool VUsuarios, bool RUsuarios)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosUsuarios @NombreRol, @EUsuarios, @VUsuarios, @RUsuarios", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@EUsuarios", EUsuarios);
                comando.Parameters.AddWithValue("@VUsuarios", VUsuarios);
                comando.Parameters.AddWithValue("@RUsuarios", RUsuarios);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoCotizacion(string NombreRol, bool ECotizacion, bool VCotizacion, bool RCotizacion)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosCotizaciones @NombreRol, @ECotizacion, @VCotizacion, @RCotizacion", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@ECotizacion", ECotizacion);
                comando.Parameters.AddWithValue("@VCotizacion", VCotizacion);
                comando.Parameters.AddWithValue("@RCotizacion", RCotizacion);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoFactura(string NombreRol, bool EFactura, bool VFactura, bool RFactura)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosFacturas @NombreRol, @EFactura, @VFactura, @RFactura", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@EFactura", EFactura);
                comando.Parameters.AddWithValue("@VFactura", VFactura);
                comando.Parameters.AddWithValue("@RFactura", RFactura);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoClientes(string NombreRol, bool ECliente, bool VCliente, bool RCliente)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosClientes @NombreRol, @ECliente, @VCliente, @RCliente", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@ECliente", ECliente);
                comando.Parameters.AddWithValue("@VCliente", VCliente);
                comando.Parameters.AddWithValue("@RCliente", RCliente);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoReporte(string NombreRol, bool EReporte, bool VReporte, bool RReporte)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosReportes @NombreRol, @EReporte, @VReporte, @RReporte", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@EReporte", EReporte);
                comando.Parameters.AddWithValue("@VReporte", VReporte);
                comando.Parameters.AddWithValue("@RReporte", RReporte);
                await comando.ExecuteNonQueryAsync();
            }
        }

        public async Task PermisoCaso(string NombreRol, bool ECasos, bool VCasos, bool RCasos)
        {
            using (var conexion = new SqlConnection(_connectionString))
            {
                await conexion.OpenAsync();
                var comando = new SqlCommand("EXEC usuarios.InsertarPermisosCasos @NombreRol, @ECasos, @VCasos, @RCasos", conexion);
                comando.Parameters.AddWithValue("@NombreRol", NombreRol);
                comando.Parameters.AddWithValue("@ECasos", ECasos);
                comando.Parameters.AddWithValue("@VCasos", VCasos);
                comando.Parameters.AddWithValue("@RCasos", RCasos);
                await comando.ExecuteNonQueryAsync();
            }
        }

    }
}
