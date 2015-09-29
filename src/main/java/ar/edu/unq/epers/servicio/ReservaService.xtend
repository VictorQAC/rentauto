package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import java.sql.Date
import ar.edu.unq.epers.model.Auto

class ReservaService {
	
	def void guardar(Reserva unaReserva){
	       
	       SessionManager.runInSession([
			
			new ReservaHome().save(unaReserva)
			unaReserva
		])
	 }
	
	def crearReserva(Integer numeroSolicitud,Ubicacion origen,Ubicacion destino,Date inicio,Date fin, Auto auto,Usuario usuario) {
		
		SessionManager.runInSession([
			var Reserva res = new Reserva(numeroSolicitud,origen,destino,inicio,fin,auto,usuario)
			new ReservaHome().save(res)
			auto
      ])	
	}
	  
}