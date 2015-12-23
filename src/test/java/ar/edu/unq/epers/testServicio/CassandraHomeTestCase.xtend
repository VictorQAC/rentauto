package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.CassandraHome
import org.junit.Before
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.servicio.AutoService
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo

class CassandraHomeTestCase {
	
	var Auto auto1
	var Auto auto2
	var Auto auto3
	var AutoService autServ
	var CassandraHome csHome
	var Ubicacion Palermo
	var Categoria deportivo
	
	@Before
	
	def void startUp(){
		
		Palermo = new Ubicacion("palermo")
		deportivo = new Deportivo()
		autServ = new AutoService()
		csHome = new CassandraHome()
		
		autServ.crearAuto("Fiesta","arg122",2010,"ford",12.5,Palermo,deportivo)
	}
	
	def void cacheVaciaTest(){
		
		val busqueda = csHome.buscarAutos(auto1)
	}
	
}