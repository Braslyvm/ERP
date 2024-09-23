

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
    public string C_Bodega{get; set;}

     public string NombreB{get; set;}
     
}
public class GestionI {
    public string C_Bodega{get; set;}

     public string c_articulo{get; set;}
      public string nombreA{get; set;}
    public int cantidad{get; set;}
     
}

}