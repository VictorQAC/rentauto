package home

import servicio.Usuario

interface IHome {
	def void guardaUsuario(Usuario us)
	def Usuario traerUsuario(String nombreUsuario)
}