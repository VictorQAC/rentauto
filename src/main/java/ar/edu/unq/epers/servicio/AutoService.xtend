package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import java.util.List
import java.sql.Date

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
	
	def modificarUbicacion(int id, Ubicacion ubicacion) {
		SessionManager.runInSession([
			var auto = new AutoHome().get(id)
			auto.ubicacionInicial = ubicacion
			auto
		]);
	}
	
	def List<Auto> autosExistentes(){
		SessionManager.runInSession([
			new AutoHome().getAll()
		])
	}
	
	def List<Auto> autosPosibles(Date principio, Date fin, Ubicacion origen, Ubicacion destino, String categoria){
		SessionManager.runInSession([
			var List<Auto> list = new AutoHome().getAutosPosibles(principio,fin,categoria)
		
			return list.filter[ it.ubicacionParaDia(principio).nombre == origen.nombre && 
								it.ubicacionParaDia(fin).nombre == destino.nombre] as List<Auto>
		])
		
		
	}
}