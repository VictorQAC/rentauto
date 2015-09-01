package home

import Excepciones.UsuarioExisteException
import Excepciones.UsuarioNoExisteException
import java.util.ArrayList
import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import servicio.Usuario

@Accessors 
class HomeEnMemoria implements IHome {
	
	List<Usuario> usuarios
	Map<Integer,Boolean> codigos; 
	
	
	new(){
		usuarios = new ArrayList<Usuario>
		
		
	}
	
	
	override existeUsuario(String idUsuario){
		usuarios.exists[usuario | usuario.getIdNombre == idUsuario]
	}
	
	override guardaUsuario(Usuario us) {
		if(!existeUsuario(us.getIdNombre)){
			//us.codigoValidacion =  (Math.random()*1000 ) as Integer	//*****************
			usuarios.add(us)
	//		codigos.put(us.codigoValidacion,false)
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
	
	override validarCodigo(String codigoValidacion) {
//		var entero = Integer.parseInt(codigoValidacion)
//		if( codigos.containsKey(entero) )
//			codigos.put( entero ,true)
	}
	
}