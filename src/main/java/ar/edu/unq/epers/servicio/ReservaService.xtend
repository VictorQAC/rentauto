package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import java.util.List
import ar.edu.unq.epers.model.Usuario

class ReservaService {
	
	var AutoService autoService = new AutoService()
	var UsuarioService usuarioService = new UsuarioService()
	
	def consultarReserva(int numeroSolicitud){
	       
	       SessionManager.runInSession([
			
			new ReservaHome().get(numeroSolicitud)
			
		])
	 }
	
	def crearReserva(Ubicacion origen,Ubicacion destino,Date inicio,Date fin, Auto auto,Usuario usuario) {
		
		SessionManager.runInSession([
			var Reserva res = new Reserva(origen,destino,inicio,fin,auto,usuario)
			res.reservar()
			new ReservaHome().save(res)
			res
      ]);	
	}
	
	def realizarReserva(Ubicacion origen,Ubicacion destino,Date inicio,Date fin, Auto auto,Usuario usuario){
		this.crearReserva(origen,destino,inicio,fin,auto,usuario)
	}
	
	
}