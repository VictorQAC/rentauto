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
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.servicio.ReservaService
import ar.edu.unq.epers.servicio.UsuarioService

class CassandraHomeTestCase {
	
	var Auto auto1
	var Auto auto2
	var Auto auto3
	var AutoService autServ
	var CassandraHome csHome
	var Ubicacion palermo
	var Ubicacion quilmes
	var Categoria deportivo
	var Date fecha
	var Date fechaFin
	var ReservaService reservaService
	var UsuarioService userServ
	var  Ubicacion palermo2
	var Ubicacion palermo3
	var Ubicacion palermo4
	
	@Before
	
	def void setUp(){
		 
		palermo = new Ubicacion("palermo")
	    palermo2 = new Ubicacion("palermo")
	    palermo3 = new Ubicacion("palermo")
	    palermo4 = new Ubicacion("palermo")
		quilmes = new Ubicacion("quilmes")
		deportivo = new Deportivo("Deport")
		autServ = new AutoService()
		csHome = new CassandraHome()
		fecha = new Date(2015,02,2)
		fechaFin = new Date(2015,02,12)
		reservaService = new ReservaService()
		userServ = new UsuarioService()
	  
	  	userServ.guardarUsuario("carlos","grillo","cargrillo","mail@hotmail.com","123",fecha)
		
		
		autServ.crearAuto("Fiesta","arg122",2010,"ford",12.5,palermo,deportivo)
		
		autServ.crearAuto("Corsa","arg123",2007,"chevrolet",12.5,palermo3,deportivo)
		
		var auto = autServ.consultarAuto(1)
		var user = userServ.consultarUsuario(1)
		reservaService.crearReserva(palermo2,quilmes,fecha,fechaFin,auto,user)
		
		csHome.connect()
		csHome.createSchema()
		
	}
	
	@After
	def void eliminarTablas() {
		  SessionManager::resetSessionFactory()
	     csHome.close()
	   
	}
	
	@Test
	def void cacheVaciaTest(){
		
		val busqueda = csHome.buscarAutos(fecha.toString,palermo.nombre)
		Assert.assertNull(busqueda)
	}
	
	@Test
	def void cacheConAutosTest(){
		
		val busqueda = csHome.autosDisponiblesPara(fecha,palermo)
		Assert.assertEquals(1,busqueda.autos.size())
	}
	
	@Test
	def void cacheActualizadaTest(){
		
		val busqueda = csHome.autosDisponiblesPara(fecha,palermo)
		Assert.assertEquals(1,busqueda.autos.size())
		reservaService.crearReserva(palermo4,quilmes,fecha,fechaFin,auto,user)
	}
	
	

	
	
}