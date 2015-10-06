package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.servicio.ReservaService
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.servicio.Usuario
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Categoria
import org.junit.Before
import java.sql.Date
import org.junit.Test
import org.junit.Assert
import java.util.List
import org.junit.After
import ar.edu.unq.epers.home.SessionManager

class ReservaServiceTestCase {
	 
	var ReservaService resServ
	var Reserva reserva
	var Ubicacion origen
	var Ubicacion destino
	var Ubicacion ubic
	var Auto auto1
	var Auto auto2
	var Usuario jose
	var Categoria cat2
	var Date fechaInicio
	var Date fechaFin
	var Date fechaNac
	
	
	@Before
	def void StartUp(){
	
	  resServ = new ReservaService()
	  origen = new Ubicacion("Constitucion")
	  destino = new Ubicacion("La Plata")
	  ubic = new Ubicacion("Florencio Varela")
	  cat2 = new Familiar("familia")
	  auto1 = new Auto("Fiat","Palio",2001,"abc234",cat2,15.25,origen)
	  auto2 = new Auto("Ford","Escort",1989,"abc234",cat2,10.5,destino)
	  fechaInicio = new Date(10-02-2015)
	  fechaFin = new Date(17-02-2015)
	  fechaNac = new Date(1-03-2000)
	  jose = new Usuario("jose","suarez","joss","josecito@hotmail","eramospocos",fechaNac)
	  
	  resServ.crearReserva(origen,destino,fechaInicio,fechaFin,auto1,jose)
	}
	
	@After
    def void limpiar() {
        SessionManager::resetSessionFactory()
	
	}
	
	@Test
	def void consultaTest(){
		
		reserva = resServ.consultarReserva(1)
		Assert.assertEquals(reserva.destino.nombre,"La Plata")
	}
	
	
	@Test
	def void realizarReservaTest(){
		
		//Assert.assertEquals(jose.reservas.length(),0)
		jose.realizarReserva(origen,ubic,fechaInicio,fechaFin,auto1)
		
		//Assert.assertEquals(jose.reservas.length(),1)
		
		reserva = resServ.consultarReserva(2)
		Assert.assertEquals(reserva.destino.nombre,"Florencio Varela")
	}
	
}