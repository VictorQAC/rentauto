package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

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
	var Date fechaDeNacimiento
	var String codigoDeValidacion
	var Boolean estadoDeValidacion
	var List<Reserva> reservas


	/**
	 * Constructor de la clase Usuario.
	 * @param unNombre = Es el nombre que tendra el usuario.
	 * @param unApellido = Es el apellido que tendra el usuario.
	 * @param unNombreDeUsuario = Es el nombre de usuario que tendra el usuario.
	 * @param unEmail = Es el email que tendra el usuario.
	 * @param unaFechaDeNacimiento = Es el fecha de nacimiento que tendra el usuario.
	 * @param codigoDeValidacion = es el codigo para validar el usuario
	 * @param estadoDeValidacion = booleano que indica el estado
	 */
	 new(){}
	 
	new(String unNombre, String unApellido, String unNombreDeUsuario,
			String unEmail,String unPassword, Date unaFechaDeNacimiento) {
		nombre = unNombre;
		apellido = unApellido;
		idNombre = unNombreDeUsuario;
		password = unPassword;
		email = unEmail;
		fechaDeNacimiento = unaFechaDeNacimiento;
		codigoDeValidacion = null;
		estadoDeValidacion = false;
		reservas = new ArrayList
	}
	

	override agregarReserva(Reserva unaReserva) {
		
		unaReserva.reservar()
	}

	override getReservas() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def validate() {
		this.estadoDeValidacion= true
	}
	
	def actualizarPassword(String nuevaPassword) {
		this.password = nuevaPassword
	}
	
	
}