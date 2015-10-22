package ar.edu.unq.epers.servicio

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.excepciones.ValidacionException
import ar.edu.unq.epers.excepciones.UsuarioExisteException
import ar.edu.unq.epers.excepciones.NuevaPasswordInvalidaException
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import ar.edu.unq.epers.home.UsuarioHomeSQL
import ar.edu.unq.epers.model.Usuario

@Accessors
class RegistroyLogin {

	var UsuarioHomeSQL uh 
	var EnviadorDeMails em 
	var GeneradorDeCodigo gen
	
	new(UsuarioHomeSQL usHome, EnviadorDeMails enMail,GeneradorDeCodigo genCod){
		uh = usHome
		em = enMail
		gen = genCod
	}
	
	/**
	 * Genera un codigo de validacion al usuario.
	 */
	def generarCodigoDeValidacionParaUsuario(){
		return gen.generarCodigo
	}
	 
	 /**
	 * Valida al usuario perteneciente al codigo de validacion dado.
	 * @param codigoValidacion = Es el codigo de validacion utilizado para obtener al
	 * usuario a validar.
	 * @throws ValidacionException
	 */
	def void validarCuenta(String codigoValidacion){
		var Usuario user = uh.getUsuarioPorCodigoDeValidacion(codigoValidacion)
		if(user == null){
			throw new ValidacionException
		}
		user.validate();
		this.uh.actualizar(user)
	}
	
	
	/**
	 * Persiste el usuario a la base de datos si este no estaba persitido
	 * con anterioridad en la base de datos.
	 * @param usuarioNuevo = El usuario a persistir en la base de datos.
	 * @throws UsuarioExisteException
	 */
	def registrarUsuario(Usuario usuarioNuevo) {
		var String cdv
		if (this.usuarioExistente(usuarioNuevo.idNombre)){
			throw new UsuarioExisteException
		}
		cdv = this.generarCodigoDeValidacionParaUsuario()
		usuarioNuevo.codigoDeValidacion = cdv
		this.uh.guardar(usuarioNuevo)
		val Mail mailConCodValidacion = new Mail (cdv,"Codigo De Validacion",
											"Sistema Administrador",usuarioNuevo.idNombre)
		enviarMailConValidacion(mailConCodValidacion)
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
		var Usuario user = uh.getUsuarioPorIDNombre(idNombre)
		if(password != nuevaPassword){
			user.actualizarPassword(nuevaPassword)
			this.uh.actualizar(user)
		}
		else
			throw new NuevaPasswordInvalidaException
	}
		
	/**
	 * Retorna true si el usuario existe,false en caso contrario.
	 * @param idNombre = Es el ID del ususario.
	 */
	def usuarioExistente(String idNombre){
		return this.uh.existeUsuario(idNombre)
	}
	
	/**
	 * Retorna true si el usuario ingreso correctamente sus datos.
	 * @param userName = Es el ID del ususario.
	 * @param password = Es el password el usuario.
	 * @throws UsuarioNoExisteException
	 */
	def ingresarUsuario(String idNombre, String password) {
		if (this.usuarioExistente(idNombre)){
			this.uh.loguearse(idNombre,password)
		}
		else
			throw new UsuarioNoExisteException
	}
	
	/** 
	 * Retorna true si el usuario ingreso correctamente al sistema
	 * @param usuario = Es el usuario que ingresa al sistema  
	 */
	
	def usuarioIngresadoCorrectamente(Usuario usuario) {
		
	   return this.uh.loguearse(usuario.idNombre,usuario.password) == usuario
	}
	
	/**
	 * Retorna true si el usuario cambio correctamente su password
	 * @param usuario = Es el usuario que cambio su password
	 * @param nuevaPass = Es la password nueva que eligio el usuario
	 */
	
	def passwordCambiadoCorrectamente(Usuario usuario,String nuevaPass) {
		
		return uh.getPassword(usuario.idNombre) == nuevaPass
	}
	
	/**
	 * Envia el mail con el codigo de validacion 
	 * @param mail = Es el mail a enviar
	 */
	def void enviarMailConValidacion(Mail mail){
		
		em.enviarMail(mail)
	}
}