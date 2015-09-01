package home

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import servicio.Usuario

@Accessors
class HomeEnMemoria implements IHome {

	List<Usuario> usuarios

	/**
	 * Guarda un usuario en la base de datos.
	 * @param usuario = El usuario a persitir en la base de datos.
	 */
	override persistirUsuario(Usuario usuario) {
		usuarios.add(usuario)
	}

	/**
	 * Recupera un usuario en la base de datos.
	 * @param nombreDelUsuario = El usuario a recuperar de la base de datos.
	 */
	override recuperarUsuario(String nombreUsuario) {
		usuarios.findFirst[usuario | usuario.idNombre == nombreUsuario]
	}
	
	/**
	 * Recupera un usuario segun su codigo de validacion en la base de datos.
	 * @param codigoDeValidacion = El codigo de validacion del usuario
	 * a recuperar de la base de datos.
	 */
	override recuperarUsuarioSegunCodigoDeValidacion(String codigoDeValidacion) {
		usuarios.findFirst[usuario | usuario.codigoDeValidacion == codigoDeValidacion]
	}

}