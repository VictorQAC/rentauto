package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto

class AutoHome {
	
	def void save(Auto unAuto){
   
		SessionManager.getSession().saveOrUpdate(unAuto)
	}
	
	def Auto get(String patente){
		
		return SessionManager.getSession().get(typeof(Auto) ,patente) as Auto
	}
}