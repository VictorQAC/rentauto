package home

import java.util.List
import servicio.Usuario
import Excepciones.UsuarioNoExisteException
import Excepciones.UsuarioExisteException

class HomeEnMemoria implements IHome {
	
	var List<Usuario> usuarios
	
	def existeUsuario(String idUsuario){
		usuarios.exists[usuario | usuario.getIdNombre == idUsuario]
	}
	
	override guardaUsuario(Usuario us) {
		if(!existeUsuario(us.getIdNombre)){
			usuarios.add(us)
		}
		else{
			throw new UsuarioExisteException
		}
	}
	
	override traerUsuario(String idUsuario) {
		if(existeUsuario(idUsuario)){
			return usuarios.findFirst[usuario | usuario.getIdNombre == idUsuario]
		}
		else{
			throw new UsuarioNoExisteException
		}
		
	}
}