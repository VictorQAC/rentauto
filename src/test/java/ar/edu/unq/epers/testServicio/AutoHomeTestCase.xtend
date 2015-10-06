package ar.edu.unq.epers.testServicio

import org.junit.Before
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.servicio.AutoService
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.UbicacionVirtual
import org.junit.After
import ar.edu.unq.epers.home.SessionManager
import java.sql.Date

class AutoHomeTestCase {
	
	var AutoService autServ
	var Auto auto1
	var Auto auto2
	var Categoria cat1
	var Ubicacion ubic
	var Ubicacion ubicacion
	var Date fecha
	var Date fecha2
	
	
	
	@Before
	def void startUp(){
		autServ = new AutoService()
		cat1 = new Deportivo("lujoso")
		cat1.nombre = "algo"
		ubic = new Ubicacion("Retiro")
		ubicacion = new Ubicacion("Palermo")
		fecha = new Date(2015-12-1)
		fecha2 = new Date(2015-12-3)
		
		autServ.crearAuto("Ford","Mustang",2000,"arg123",2.5,ubic,cat1)
		autServ.crearAuto("Ford","Mondeo",2000,"arg123",2.5,ubic,cat1)
	}
	
	@After
    def void limpiar() {
        SessionManager::resetSessionFactory()
}
	
	@Test
	def void testCrear(){
		
		auto1 = autServ.consultarAuto(1)
		Assert.assertEquals(auto1.patente,"arg123")
	}
	
	@Test
	def void modificarUbicacion(){
		var UbicacionVirtual ubc2 = new UbicacionVirtual("Avellaneda")
		autServ.modificarUbicacion(1,ubc2)
		var Auto auto2 = autServ.consultarAuto(1)
		Assert.assertEquals(auto2.ubicacionInicial.nombre,ubc2.nombre)
	}
	
	@Test
	def void testAutosDisponibles(){
		
		Assert.assertEquals(autServ.autosExistentes().size,2)
	}
	
	@Test
	def void autosPosiblesTest(){
		
		Assert.assertEquals(autServ.autosPosibles(ubic,ubicacion,fecha,fecha2,cat1).size,2)
  	}
	
	@Test
	def void reservasDisponiblesTest(){
		
		
  	}

}