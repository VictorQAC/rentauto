package ar.edu.unq.epers.testServicio

import org.junit.Before
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.servicio.AutoService

class AutoHomeTestCase {
	
	var AutoService autServ
	var Auto auto1
	var Categoria cat1
	var Ubicacion ubic
	
	@Before
	def void setUp(){
		
		autServ = new AutoService()
		cat1 = new Familiar()
		ubic = new Ubicacion("Retiro")
		//auto1 = new Auto("Ford","Mustang",2000,"arg123",cat1,2.5,ubic)
	}
	
	@Before
	def void startUp(){
		new AutoService().crearAuto("Ford","Mustang",2000,"arg123",2.5,ubic)
	}
	
	@Test
	def void testCrear(){
		
		auto1 = autServ.consultarAuto(1)
		Assert.assertEquals(auto1.patente,"arg123")
	}
}