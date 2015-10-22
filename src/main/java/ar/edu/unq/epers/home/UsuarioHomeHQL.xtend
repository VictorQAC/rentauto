package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario

class UsuarioHomeH {
	
	def void save(Usuario usuario){
   
		SessionManager.getSession().saveOrUpdate(usuario)
	}
  	
  	def Usuario get(int id_usuario){
		
		return SessionManager.getSession().get(typeof(Usuario) ,id_usuario) as Usuario
	}
	
	def getUsuarioPorCodigoDeValidacion(String codigoValidacion){
		
		val query = SessionManager::getSession().createQuery("select from Usuario as usuario where 
																codigoDeValidacion = :codigoValidacion")
		query.setString("codigoDeValidacion",codigoValidacion)
		return query as Usuario 
	}
}