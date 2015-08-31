package servicio

import home.HomeEnMemoria
import home.IHome
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SistemaRegistroyLogin {
	
	val IHome home = new HomeEnMemoria 
	new(){
		
	}
	
	/**
	 * 
	 */
	def registrarUsuario (Usuario usuarioNuevo) {
		home.guardaUsuario(usuarioNuevo)
	}
	
	def ingresarUsuario ( String userName, String password){
	}

	
}