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

class ReservaServiceTestCase {
	 
	var ReservaService resServ
	var Reserva reserva
	var Ubicacion origen
	var Ubicacion destino
	var Ubicacion ubic
	var Auto auto1
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
	  auto1 = new Auto("Fiat","Palio",2001,"abc234",cat2,15.25,ubic)
	  fechaInicio = new Date(10-02-2015)
	  fechaFin = new Date(17-02-2015)
	  fechaNac = new Date(1-03-2000)
	  jose = new Usuario("jose","suarez","joss","josecito@hotmail","eramospocos",fechaNac)
	  
	  resServ.crearReserva(1,origen,destino,fechaInicio,fechaFin,auto1,jose)
	}
	
	
	@Test
	def void consultaTest(){
		
		reserva = resServ.consultarReserva(1)
		Assert.assertEquals(reserva.destino.nombre,"La Plata")
	}
	
	
}