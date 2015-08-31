package servicio

import ar.edu.unq.epers.model.IUsuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class SistemaRegistroyLogin {
	
	List<IUsuario> usuarios;
	new(){
		usuarios = new ArrayList<IUsuario>();
	}
	
	/**
	 * 
	 */
	def registrarUsuario (Usuario usuarioNuevo) {
//		home.existeUsuario(usuarioNuevo.nombreUsuario)
	}
	
	def ingresarUsuario ( String userName, String password){
	}

	
}