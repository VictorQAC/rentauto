package servicio

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Usuario implements IUsuario {
	
	var String nombre;
	var String apellido;
	var String idNombre;
	var String email;
	var Date fechaDeNacimiento;
	
	/**
	 * Constructor
	 */
	new(String unNombre,String unApellido,String nombreDeUsuario1,String unEmail,Date fechaDeNac){
		nombre = unNombre;
		apellido = unApellido;
		idNombre = nombreDeUsuario1;
		email = unEmail;
		fechaDeNacimiento = fechaDeNac; 
	}
	
		
	override agregarReserva(Reserva unaReserva) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getReservas() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	
	// esto lo hizo lucas.
	
}