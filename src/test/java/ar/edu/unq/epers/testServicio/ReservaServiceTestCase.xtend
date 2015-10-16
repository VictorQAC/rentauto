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
import ar.edu.unq.epers.servicio.AutoService
import ar.edu.unq.epers.servicio.UsuarioService

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
	var AutoService autoServ
	var Usuario usuario
	var UsuarioService userServ
	
	
	@Before
	def void StartUp(){
	

	  resServ = new ReservaService()
	  
	  origen = new Ubicacion("Constitucion")
	  destino = new Ubicacion("La Plata")
	  ubic = new Ubicacion("Constitucion")
	  
	  cat2 = new Familiar("familia")
	  
	  fechaInicio = new Date(10-02-2015)
	  fechaFin = new Date(17-02-2015)
	  fechaNac = new Date(1-03-2000)
	  

	 
	  autoServ = new AutoService() 
	  userServ = new UsuarioService()
	  
	  userServ.guardarUsuario("carlos","grillo","cargrillo","mail@hotmail.com","123",fechaNac)
	  autoServ.crearAuto("Ford","Palio",2001,"abc234",15.25,origen,cat2)// auto1 en memoria
	  
	  
	
	}
	 
	@After
    def void limpiar() {
        SessionManager::resetSessionFactory()
	
	}
	 
	@Test
	def void consultaTest(){
		
	
		
		auto1 = autoServ.consultarAuto(1)
		usuario =  userServ.consultarUsuario(1)
		
		resServ.crearReserva(ubic,destino,fechaInicio,fechaFin,auto1,usuario)
		reserva = resServ.consultarReserva(1)
		
		Assert.assertEquals(reserva.destino.nombre,"La Plata")
	}
	
	@Test
	def void gestionarReservaTest(){
		
			
		
		auto1 = autoServ.consultarAuto(1)
		usuario =  userServ.consultarUsuario(1)
		
		Assert.assertEquals(auto1.reservas.size,0)
		
	    resServ.crearReserva(ubic,destino,fechaInicio,fechaFin,auto1,usuario)
		
		Assert.assertEquals(auto1.reservas.size,1)
	}
	
}