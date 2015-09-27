package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Reserva

class ReservaHome {
	
  def void save(Reserva unaReserva){
   
		SessionManager.getSession().saveOrUpdate(unaReserva)
	}
  	
 }
