package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto
import java.util.List
import java.util.Date
import ar.edu.unq.epers.model.Ubicacion

class AutoHome {
	
	def void save(Auto unAuto){
   
		SessionManager.getSession().saveOrUpdate(unAuto)
	}
	
	def Auto get(int id){
		
		return SessionManager.getSession().get(typeof(Auto) ,id) as Auto
	}
	
	def List<Auto> getAll(){
		/*val query = SessionManager::getSession().createQuery("Select from Auto as auto
			join Auto.reservas.reserva 
			where((reserva = null OR (inicio > reserva.final AND fin < reserva.inicial)) 
					AND (reserva != null) OR (auto.ubicacion = origen))")*/
					
		val query = SessionManager::getSession().createQuery("from Auto")
      	return query.list()
	}
}
