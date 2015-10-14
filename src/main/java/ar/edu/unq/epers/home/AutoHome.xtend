package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto
import java.util.List
import java.util.Date
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Categoria

class AutoHome {
	
	def void save(Auto unAuto){
   
		SessionManager.getSession().saveOrUpdate(unAuto)
	}
	
	def Auto get(int id){
		
		return SessionManager.getSession().get(typeof(Auto) ,id) as Auto
	}
	
	def List<Auto> getAll(){
		/*val query = SessionManager::getSession().createQuery("from Auto as auto
			join Auto.reservas as reserva 
			where((reserva = null OR (inicio > reserva.final AND fin < reserva.inicial)) 
					AND (reserva != null) OR (auto.ubicacion = origen))")*/
					
		val query = SessionManager::getSession().createQuery("from Auto")
      	return query.list()
	}
	
	def List<Auto> getAutosPosibles(Date principio, Date finalizacion,String categoria) {
		
		val query = SessionManager::getSession().createQuery(("from Auto as auto left join auto.reservas as reserva where reserva == null OR (:principio > reserva.final AND :finalizacion < reserva.inicial AND :categoria == reserva.auto.categoria.nombre))"))
		
		query.setDate("principio",principio)
		query.setDate("finalizacion",finalizacion)
		query.setString("categoria",categoria)							    	
		return query.list					  
     	
	}
}
