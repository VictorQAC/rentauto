package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.EqualsHashCode
import com.datastax.driver.mapping.annotations.UDT
import com.datastax.driver.mapping.annotations.Table
import com.datastax.driver.mapping.annotations.PartitionKey
import java.util.List
import com.datastax.driver.mapping.annotations.FrozenValue

@Accessors
@EqualsHashCode
@UDT(keyspace = "simplex", name = "autoCache")
class AutoCache {
	
	String patente
	
	new() {
	}
	
	new(String patente){
		
		this.patente = patente
	}
	
}

@Accessors
@Table(keyspace = "simplex", name = "autosDisponibles")
class AutosDisponibles {
	@PartitionKey(0)
    String dia
    @PartitionKey(1)
	String ubicacion
	@FrozenValue
	List<AutoCache> autos
	
	new() {
		
	}
	
	new(String dia, String ubicacion, List<AutoCache> autos){
		
		this.dia = dia
		this.ubicacion = ubicacion
		this.autos = autos
	}
	
}