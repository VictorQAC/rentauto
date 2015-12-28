package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import java.util.List
import java.util.Date
import ar.edu.unq.epers.model.Reserva

class AutoService {
	
	def consultarAuto(int id) {
		SessionManager.runInSession([
			new AutoHome().get(id)
		])
	}

	def crearAuto(String marca, String modelo, Integer anio, String patente, Double costoBase,Ubicacion ubicacion,Categoria cat) {
		SessionManager.runInSession([
			var auto = new Auto(marca, modelo, anio,patente,cat,costoBase,ubicacion)
			new AutoHome().save(auto)
			auto
			
		]);
	}
	
	def persistirAuto(Auto unAuto) {
		SessionManager.runInSession([
			
			new AutoHome().save(unAuto)
			unAuto
			
		]);
	}
	
	def modificarUbicacion(int id, Ubicacion ubicacion) {
		SessionManager.runInSession([
			var auto = new AutoHome().get(id)
			auto.ubicacionInicial = ubicacion
			auto
		]);
	}
	
	def Iterable<Auto> autosDisponibles(Ubicacion unaUbicacion , Date unDia){
		SessionManager.runInSession([
			var Iterable<Auto> list = new AutoHome().getAll()
			return list.filter[estaEnLaUbicacion(unaUbicacion,unDia)]
		])
	}
	
	def Iterable<Auto> autosPosibles(Date principio, Date fin, Ubicacion origen, Ubicacion destino, Categoria categoria){
		SessionManager.runInSession([
			var Iterable<Auto> list = new AutoHome().getAutosPosibles(principio,fin,categoria)
			
			return list.filter[ it.ubicacionParaDia(principio).nombre == origen.nombre && 
							    it.ubicacionParaDia(fin).nombre == destino.nombre]
		])	
	}
	
	def void agregarReserva(Integer autoId, Reserva reserva) {
		val autoActualizado = this.consultarAuto(autoId)
		autoActualizado.agregarReserva(reserva)
		this.persistirAuto(autoActualizado)
	}
	
	def List<String> obtenerPatentes(Iterable<Auto> autos){
		
		var aut = autos as List<Auto>
		
		var List<String> patentes
		
		for(var i=0;i < aut.size;i++){
			
		   patentes.add((aut.get(i)).getPatente())
		}
		return patentes
	}
}