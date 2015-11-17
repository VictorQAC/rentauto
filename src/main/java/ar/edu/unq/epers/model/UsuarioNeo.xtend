package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class UsuarioNeo {
	var String nombre
	var String apellido
	var String idNombre
	var String password
	var String email

	override equals(Object obj) {
		if (obj === this) {
			return true;
		}
		if (obj instanceof UsuarioNeo) {
			val other = obj as UsuarioNeo
			return this.idNombre == other.idNombre;	
		}
		return false;
	}

	override hashCode() {
		return this.idNombre.hashCode
	}
	
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
		
	}
	
}