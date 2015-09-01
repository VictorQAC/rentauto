package home

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class UsuarioHome {

	var String nombre
	var String apellido
	var String idNombre
	var String password
	var String email
	var String fechaDeNacimiento
	var String codigoDeValidacion
	var Boolean estadoDeValidacion

}