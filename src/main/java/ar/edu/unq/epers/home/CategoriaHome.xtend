package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Categoria

class CategoriaHome {
	
	def void save(Categoria unaCategoria){
   
		SessionManager.getSession().saveOrUpdate(unaCategoria)
	}
	
	def Categoria get(String nombre){
		
		return SessionManager.getSession().get(typeof(Categoria),nombre) as Categoria
    }

}