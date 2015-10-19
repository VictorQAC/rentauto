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
	
	/*def void gestionarReserva(Usuario usuario, Auto auto, Ubicacion origen, Ubicacion destino, Date inicio, Date fin) {
		SessionManager.runInSession([
		//var Usuario user = usuarioService.consultarUsuario(usuario.idUsuario)
		//var Auto auto = autoService.consultarAuto(idAuto)
		var Reserva reserva = new Reserva(origen,destino,inicio,fin,auto,usuario)
		autoService.agregarReserva(auto.id, reserva)
		usuarioService.persistirUsuario(usuario)
		new ReservaHome().save(reserva)
		reserva
		])
	}*/
	
	def realizarReserva(Ubicacion origen,Ubicacion destino,Date inicio,Date fin, Auto auto,Usuario usuario){
		this.crearReserva(origen,destino,inicio,fin,auto,usuario)
	}
	
	
}