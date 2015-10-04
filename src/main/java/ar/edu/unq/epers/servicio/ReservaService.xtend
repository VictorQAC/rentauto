package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Auto

class ReservaService {
	
	def consultarReserva(int numeroSolicitud){
	       
	       SessionManager.runInSession([
			
			new ReservaHome().get(numeroSolicitud)
			
		])
	 }
	
	def crearReserva(Integer numeroSolicitud,Ubicacion origen,Ubicacion destino,Date inicio,Date fin, Auto auto,Usuario usuario) {
		
		SessionManager.runInSession([
			var Reserva res = new Reserva(origen,destino,inicio,fin,auto,usuario)
			new ReservaHome().save(res)
			res
      ])	
	}
	  
}