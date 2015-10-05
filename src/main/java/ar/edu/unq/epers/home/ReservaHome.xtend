package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Categoria
import java.util.List

class ReservaHome {
	
  def void save(Reserva unaReserva){
   
		SessionManager.getSession().saveOrUpdate(unaReserva)
	}
  	
  	def Reserva get(int numeroSolic){
		
		return SessionManager.getSession().get(typeof(Reserva) ,numeroSolic) as Reserva
	}
	
	
	def List<Reserva> getReservas(Ubicacion partida, Ubicacion llegada, Date principio, Date finalizacion, Categoria categoria) {
		
		val query = SessionManager::getSession().createQuery(("select from Reserva as Reserva join Reserva.autos.auto 
                      
					    (where reserva.origen = origen,
							  reserva.destino = destino,  	
                        	  reserva.inicio = principio,
	 					      reserva.fin = finalizacion,
							  reserva.auto.categoria = categoria"))

      
     	return query.list
	}
	
 }
