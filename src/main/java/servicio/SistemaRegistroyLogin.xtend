package servicio

import Excepciones.NuevaPasswordInvalidaException
import Excepciones.UsuarioExisteException
import Excepciones.UsuarioNoExisteException
import home.HomeEnMemoria
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SistemaRegistroyLogin {

	val HomeEnMemoria home = new HomeEnMemoria

	/**
	 * Retorna si existe un usuario dado en la base de datos.
	 * @param nombreDeUsuario = El nombre de usuario
	 * del usuario a recuperar en la base de datos.
	 */
	def existeUsuarioEnLaBaseDeDatos(String nombreDeUsuario) {
		!(home.recuperarUsuario(nombreDeUsuario) == null)
	}
	
	/**
	 * Retorna si el password es el correcto.
	 * @param userName = Es el nombre del usuario del cual se verificara el
	 * password.
	 * @param password = Es el password que se usara para compararlo con el
	 * password del usuario.
	 */
	def comprobarPassword(String userName, String password) {
		home.recuperarUsuario(userName).password == password
	}

	/**
	 * Persiste el usuario a la base de datos si este no estaba persitido
	 * con anterioridad en la base de datos.
	 * @param usuarioNuevo = El usuario a persistir en la base de datos.
	 * @throws UsuarioExisteException
	 */
	def registrarUsuario(Usuario usuarioNuevo) {
		if (existeUsuarioEnLaBaseDeDatos(usuarioNuevo.idNombre))
			throw new UsuarioExisteException
		else
			home.persistirUsuario(usuarioNuevo)
	}
	
	/**
	 * Retorna el usuario una vez ingresado correctamente sus datos.
	 * @param userName = Es el nombre de ususario.
	 * @param password = Es el password el usuario.
	 * @throws UsuarioNoExisteException
	 */
	def ingresarUsuario(String userName, String password) {
		if (existeUsuarioEnLaBaseDeDatos(userName) && 
			comprobarPassword(userName, password))
			home.recuperarUsuario(userName)
		else
			throw new UsuarioNoExisteException
	}
	
	/**
	 * Cambia el password del usuario dado siempre y cuando la el nuevo password
	 * sea diferente al password anterior.
	 * @param userName = Es el nombre de ususario.
	 * @param password = Es el password el usuario.
	 * @param nuevaPassword = Es el nuevo password a persistir.
	 * @throws NuevaPasswordInvalidaException
	 */
	def cambiarPassword(String userName, String password, String nuevaPassword){
		if(password != nuevaPassword)
			home.recuperarUsuario(userName).password = nuevaPassword
		else
			throw new NuevaPasswordInvalidaException
	}

}