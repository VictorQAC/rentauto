package servicio

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Usuario implements IUsuario {
	
	var String nombreUsuario;
	var String apellidoUsuario;
	var String nombreDeUsuario;
	var String emailUsuario;
	var Date fechaDeNacUsuario;
	
	/**
	 * Constructor
	 */
	new(String nombre,String apellido,String nombreDeUsuario1,String email,Date fechaDeNac){
		nombreUsuario = nombre;
		apellidoUsuario = apellido;
		nombreDeUsuario = nombreDeUsuario1;
		emailUsuario = email;
		fechaDeNacUsuario = fechaDeNac; 
	}
	
		
	override agregarReserva(Reserva unaReserva) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getReservas() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	
	// esto lo hizo lucas.
	
}