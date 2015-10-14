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
import java.util.Date
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.servicio.Usuario
import ar.edu.unq.epers.servicio.ReservaService


class AutoHomeTestCase {
	
	var AutoService autServ
	var Auto auto1
	var Auto auto2
	var Categoria cat1
	var Ubicacion ubic
	var Ubicacion ubicacion
	var Date fecha
	var Date fecha2
	var Date fecha3
	var Date fecha4
	var Reserva res
	var Usuario pepe
	var ReservaService resServ
	
	@Before
	def void startUp(){
		autServ = new AutoService()
		cat1 = new Deportivo("lujoso")
		cat1.nombre = "algo"
		ubic = new Ubicacion("Retiro")
		ubicacion = new Ubicacion("Palermo")
		fecha = new Date(2015,12,1)
		fecha2 = new Date(2015,12,3)
		fecha3 = new Date(2015,12,4)
		fecha4 = new Date(2015,12,5)
		
		
		
		autServ.crearAuto("Ford","Mustang",2000,"arg123",2.5,ubic,cat1)
		autServ.crearAuto("Ford","Mondeo",2000,"arg123",2.5,ubicacion,cat1)
		
	   
		
		pepe = new Usuario("jorge","grillo","jgrillo","mail@hotmail.com"
			,"123",new Date(10 / 11 / 1990))
		resServ = new ReservaService()	
		
		
		
		
		
		
		
	}
	
	@After
    def void limpiarBase() {
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
		auto1 = autServ.consultarAuto(1)
		Assert.assertEquals(auto1.ubicacionInicial.nombre,ubc2.nombre)
	}
	
	@Test
	def void testAutosDisponibles(){
		
		/* funciona el mjs autosDisponibles
		 */
		Assert.assertEquals(autServ.autosDisponibles(ubic ,fecha2).size,1)
	}
	
	@Test
	def void autosPosiblesTest(){
/* Trate de agregar una reserva a un auto para probar el metodo "autos posibles" 
   la idea es que al reservar un auto, quedaria uno solo posible sin reservas. 
   * Y ese es el auto que deberia devolverme el metodo "autos posibles". 
   * Pero no logro hacer correr el test
   * me tira un error que nose q es*/


         var Ubicacion ubc2 = new Ubicacion("Palermo")
		 var Ubicacion ubc3 = new Ubicacion("Retiro")
		
	     auto2 = autServ.consultarAuto(2)	
	     resServ.crearReserva(ubc2,ubc3,fecha,fecha2,auto2,pepe)
	  
	   
	  
	  
		Assert.assertEquals(autServ.autosPosibles(fecha3,fecha4,ubicacion,ubic,cat1.nombre).size,1)
  	}
	
	
}