package home

import servicio.Usuario

interface IHome {
	def void guardaUsuario(Usuario us)
	def Usuario traerUsuario(String nombreUsuario)
    def boolean existeUsuario(String idNombre)	
	def void validarCodigo(String string)
	
}