package servicio

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * La Clase Usuario representa a un usuario que querra registrarse en ingresar al
 * sistema.
 */
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
	 * Constructor de la clase Usuario.
	 * @param unNombre = Es el nombre que tendra el usuario.
	 * @param unApellido = Es el apellido que tendra el usuario.
	 * @param unNombreDeUsuario = Es el nombre de usuario que tendra el usuario.
	 * @param unEmail = Es el email que tendra el usuario.
	 * @param unaFechaDeNacimiento = Es el fecha de nacimiento que tendra el usuario.
	 */
	new(String unNombre, String unApellido, String unNombreDeUsuario,
			String unEmail, String unaFechaDeNacimiento) {
		nombre = unNombre;
		apellido = unApellido;
		idNombre = unNombreDeUsuario;
		email = unEmail;
		fechaDeNacimiento = unaFechaDeNacimiento;
		estadoDeValidacion = false
	}

	override agregarReserva(Reserva unaReserva) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getReservas() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}