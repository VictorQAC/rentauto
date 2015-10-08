package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import java.util.List

class ReservaService {
	
	def consultarReserva(int numeroSolicitud){
	       
	       SessionManager.runInSession([
			
			new ReservaHome().get(numeroSolicitud)
			
		])
	 }
	
	def crearReserva(Ubicacion origen,Ubicacion destino,Date inicio,Date fin, Auto auto,Usuario usuario) {
		
		SessionManager.runInSession([
			var Reserva res = new Reserva(origen,destino,inicio,fin,auto,usuario)
			new ReservaHome().save(res)
			res
      ])	
	}
	
	  def reservarReserva(Integer numeroSolicitud) {
		
		SessionManager.runInSession([
			
			//var rH = new ReservaHome() 
			
			var Reserva res = this.consultarReserva(numeroSolicitud)
			res.reservar()
			new ReservaHome().save(res)
			res
      ])	
	}
}