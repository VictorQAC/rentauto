package servicio

import Excepciones.NuevaPasswordInvalidaException
import Excepciones.UsuarioExisteException
import Excepciones.UsuarioNoExisteException
import home.HomeEnMemoria
import org.eclipse.xtend.lib.annotations.Accessors
import Excepciones.ValidacionException
import home.UsuarioHome

@Accessors
class SistemaRegistroyLogin {

	val UsuarioHome uh 
	val EnviadorDeMails em
	
	new(){
		uh = new UsuarioHome
		em = new Mail
	}
	
	/**
	 * Genera y asigna un codigo de validacion al usuario.
	 * @param usuario = El usuario a asignarle un codigo de validacion.
	 */
	private def generarCodigoDeValidacionParaUsuario(){
		return (Math.random()*10000).toString
	}
	 
	///// esto es lo nuevo ///////////////////////
	 
	 /**
	 * Valida al usuario perteneciente al codigo de validacion dado.
	 * @param codigoValidacion = Es el codigo de validacion utilizado para obtener al
	 * usuario a validar.
	 * @throws ValidacionException
	 */
	 
	def validarCuenta(String codigoValidacion){
		val Usuario user = uh.getUsuarioPorCodigoDeValidacion(codigoValidacion)
		if(user == null)
			throw new ValidacionException
		user.validar()
		this.uh.guardar(user)
	}
	
	
	/**
	 * Persiste el usuario a la base de datos si este no estaba persitido
	 * con anterioridad en la base de datos.
	 * @param usuarioNuevo = El usuario a persistir en la base de datos.
	 * @throws UsuarioExisteException
	 */
	def registrarUsuario(Usuario usuarioNuevo) {
		var String cdv
		if (this.uh.existeUsuario(usuarioNuevo.idNombre))
			throw new UsuarioExisteException
		else{
			cdv = this.generarCodigoDeValidacionParaUsuario()
			usuarioNuevo.codigoDeValidacion = cdv
			this.uh.guardar(usuarioNuevo)
		}
		
		val Mail mailConCodValidacion = new Mail (cdv,"Codigo De Validacion",
											"Sistema Administrador",usuarioNuevo.idNombre)
		em.enviarMail(mailConCodValidacion)
	}
	
	/**
	 * Cambia el password del usuario dado siempre y cuando la el nuevo password
	 * sea diferente al password anterior.
	 * @param userName = Es el nombre de ususario.
	 * @param password = Es el password el usuario.
	 * @param nuevaPassword = Es el nuevo password a persistir.
	 * @throws NuevaPasswordInvalidaException
	 */
	def cambiarPassword(String idNombre, String password, String nuevaPassword){
		if(password != nuevaPassword)
			uh.actualizarPassword(idNombre,nuevaPassword)
		else
			throw new NuevaPasswordInvalidaException
	}
	
	/**
	 * Retorna el usuario una vez ingresado correctamente sus datos.
	 * @param userName = Es el nombre de ususario.
	 * @param password = Es el password el usuario.
	 * @throws UsuarioNoExisteException
	 */
	def ingresarUsuario(String idName, String password) {
		if (!this.uh.existeUsuario(idName))
			this.uh.loguearse(idName,password)
		else
			throw new UsuarioNoExisteException
	}
}