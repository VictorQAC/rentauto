package home

import servicio.Usuario

interface IHome {

	/**
	 * Guarda un usuario en la base de datos.
	 * @param usuario = El usuario a persitir en la base de datos.
	 */
	def void persistirUsuario(Usuario usuario)

	/**
	 * Recupera un usuario en la base de datos.
	 * @param nombreDelUsuario = El usuario a recuperar de la base de datos.
	 */
	def Usuario recuperarUsuario(String nombreDelUsuario)
	
	/**
	 * Recupera un usuario segun su codigo de validacion en la base de datos.
	 * @param codigoDeValidacion = El codigo de validacion del usuario
	 * a recuperar de la base de datos.
	 */
	def Usuario recuperarUsuarioSegunCodigoDeValidacion(String codigoDeValidacion)
	

}