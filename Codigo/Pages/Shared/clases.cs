

namespace proyecto1bases.Models{
 public class Puesto
 {
     public string PuestoT { get; set; }
     public string Departamento { get; set; }
 }
 public class Empleado
{
    public int Cedula { get; set; }
    public string Nombre { get; set; }
    public string Apellido1 { get; set; }
    public string Apellido2 { get; set; }
    public string CorreoElectronico { get; set; }
    public string Genero { get; set; }
    public DateTime FechaNacimiento { get; set; }
    public int Edad { get; set; }
    public string LugarResidencia { get; set; }
    public int Telefono { get; set; }
    public DateTime FechaIngreso { get; set; }
    public decimal SalarioActual { get; set; }
    public string PuestoActual { get; set; }
    public string DepartamentoActual { get; set; }
    public string Rol { get; set; }
}
public class Rol {
    public string nombrerol{get; set;}
}
public class Familia {
    public string NombreF{get; set;}

     public string cfamilia{get; set;}
      public int activo{get; set;}
}
public class Articulo {
    public string nombreA{get; set;}

     public string c_articulo{get; set;}
    public bool Activo { get; set; }
    public string Descripcion { get; set; }
    public string CFamilia { get; set; }
    public decimal Peso { get; set; }
    public int Precio { get; set; }
    public int cantidad { get; set; }
     public string c_bodega { get; set; } 
   
   

     
}
  public class Local 
  {
      public string nombre_local { get; set; }
      public int cedula_juridica_local { get; set; }
      public int telefono_local { get; set; }
  }
public class Bodega {
    public int C_Bodega{get; set;}

     public string NombreB{get; set;}

     public string Ubicacion {get; set;}

    public int c_toneladas {get; set;}
    public int e_cubico {get; set;}

     
     
}
public class GestionI {
    public string C_Bodega{get; set;}

     public string c_articulo{get; set;}
      public string nombreA{get; set;}
    public int cantidad{get; set;}
     
}
public class Cotizacion {
    public int id_cotizacion{get; set;}

     public int cliente{get; set;}
    
    
     
}
public class Cliente {
    public int CedulaJ{get; set;}

     public string NombreC{get; set;}
     
      public string CorreoE{get; set;}
      public int Telefono{get; set;}
      
      public int celular{get; set;}
      public string fax{get; set;}
      public string zona{get; set;}
      public string sector{get; set;}
}

/*editar craear y borrar bodegas
Reportes de inventario 
REPORTES CLIENTES
reporte facturacion
reporte cotizacion 
pasar cotizacion a factura 
interfaz login 

*/
}