

namespace proyecto1bases.Models{
 public class Puesto
 {
     public string PuestoT { get; set; }
     public int IDpueto { get; set; }
 }
 public class Departamento
 {
     public string NombreD { get; set; } 
     public int IDdepartamento { get; set; }
 }
 public class Empleado
{
    public string NombreE { get; set; } 
    public int Cedula { get; set; }
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
    public string CedulaJ{get; set;}

     public string NombreC{get; set;}
     
      public string CorreoE{get; set;}
      public string Telefono{get; set;}
      public string celular{get; set;}
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