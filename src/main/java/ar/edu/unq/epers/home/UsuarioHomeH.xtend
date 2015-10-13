package ar.edu.unq.epers.home

import ar.edu.unq.epers.servicio.Usuario

class UsuarioHomeH {
	
	def void save(Usuario usuario){
   
		SessionManager.getSession().saveOrUpdate(usuario)
	}
  	
  	def Usuario get(int id_usuario){
		
		return SessionManager.getSession().get(typeof(Usuario) ,id_usuario) as Usuario
	}
}