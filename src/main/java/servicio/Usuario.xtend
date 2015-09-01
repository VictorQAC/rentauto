package servicio

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario implements IUsuario {

	var String nombre
	var String apellido
	var String idNombre
	var String password
	var String email
	var String fechaDeNacimiento
	var String codigoDeValidacion
	var Boolean estadoDeValidacion

	/**
	 * Constructor
	 */
	new(String unNombre, String unApellido, String nombreDeUsuario1,
			String unEmail, String unaFechaDeNacimiento) {
		nombre = unNombre;
		apellido = unApellido;
		idNombre = nombreDeUsuario1;
		email = unEmail;
		fechaDeNacimiento = unaFechaDeNacimiento;
	}

	override agregarReserva(Reserva unaReserva) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getReservas() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}