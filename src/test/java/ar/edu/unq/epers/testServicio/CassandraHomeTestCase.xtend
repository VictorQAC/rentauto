package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.CassandraHome
import org.junit.Before
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.servicio.AutoService
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo
import java.util.Date
import org.junit.Test
import org.junit.Assert
import org.junit.After

class CassandraHomeTestCase {
	
	var Auto auto1
	var Auto auto2
	var Auto auto3
	var AutoService autServ
	var CassandraHome csHome
	var Ubicacion palermo
	var Categoria deportivo
	var Date fecha
	
	@Before
	
	def void setUp(){
		
		palermo = new Ubicacion("palermo")
		deportivo = new Deportivo("Deport")
		autServ = new AutoService()
		csHome = new CassandraHome()
		fecha = new Date(12-02-2015)
		
		autServ.crearAuto("Fiesta","arg122",2010,"ford",12.5,palermo,deportivo)
		
		csHome.connect()
		csHome.createSchema()
		
	}
	
	@After
	def eliminarTablas() {
	     csHome.close()
	}
	
	@Test
	def void cacheVaciaTest(){
		
		val busqueda = csHome.autosDisponiblesPara(fecha,palermo)
		Assert.assertNull(busqueda)
	}
	
}