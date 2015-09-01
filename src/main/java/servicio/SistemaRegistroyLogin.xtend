package servicio

import Excepciones.UsuarioExisteException
import home.UsuarioHome
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SistemaRegistroyLogin {

	val UsuarioHome home = new UsuarioHome

	new() {
	}
	
	def Boolean existeUsuario(String idUsuario){
//		usuarios.exists[usuario | usuario.getIdNombre == idUsuario]
	}

	/**
	 * 
	 */
	def registrarUsuario(Usuario usuarioNuevo) {
		if(!existeUsuario(usuarioNuevo.getIdNombre)){
			home.guardarUsuario(usuarioNuevo)
		}
		else{
			throw new UsuarioExisteException
		}
	}
}