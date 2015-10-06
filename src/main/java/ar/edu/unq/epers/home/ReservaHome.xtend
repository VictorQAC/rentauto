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
	
 }
