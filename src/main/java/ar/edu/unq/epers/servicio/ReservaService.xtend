package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva

class ReservaService {
	
	def void guardar(Reserva unaReserva){
	       
	       SessionManager.runInSession([
			
			new ReservaHome().save(unaReserva)
			unaReserva
		])
	 } 
	  
	}