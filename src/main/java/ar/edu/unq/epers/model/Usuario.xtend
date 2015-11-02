package ar.edu.unq.epers.model

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria

/**
 * La Clase Usuario representa a un usuario que querra registrarse en ingresar al
 * sistema.
 */
@Accessors
class Usuario implements IUsuario {
    
    //var Integer idUsuario
	var String nombre
	var String apellido
	var String idNombre
	var String password
	var String email
	//var Date fechaDeNacimiento
	//var String codigoDeValidacion
	var Boolean estadoDeValidacion
	var List<Reserva> reservas


	
	 new(){}
	 
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
	 
	 
	new(String unNombre, String unApellido, String unNombreDeUsuario,
			String unEmail,String unPassword) {
		
		nombre = unNombre;
		apellido = unApellido;
		idNombre = unNombreDeUsuario;
		password = unPassword;
		email = unEmail;
		//fechaDeNacimiento = unaFechaDeNacimiento;
		//codigoDeValidacion = null;
		estadoDeValidacion = false;
		reservas = new ArrayList
	}
	

	override agregarReserva(Reserva unaReserva) {
		
		reservas.add(unaReserva)
		reservas.sortInplaceBy[inicio]
	
	}

	override getReservas() {
		
		return reservas
	}
	
	def validate() {
		this.estadoDeValidacion= true
	}
	
	def actualizarPassword(String nuevaPassword) {
		this.password = nuevaPassword
	}
	
	
	
	
	
}