package ar.edu.unq.epers.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors 
class Ubicacion {
	String nombre
	Integer idUbicacion
	
	new(){}
	
	new(String nombre){
		this.nombre = nombre
	}
	
}

@Accessors 
class UbicacionVirtual extends Ubicacion{
	
	List<Ubicacion> ubicaciones
	
	new(){}
	
	new(String nombre){
		this.nombre = nombre
		ubicaciones = new ArrayList()
	}
}
