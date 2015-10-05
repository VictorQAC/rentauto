package ar.edu.unq.epers.testServicio

import org.junit.Before
import ar.edu.unq.epers.model.Auto
import java.sql.Date
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.servicio.Usuario
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Empresa
import org.junit.Test
import org.junit.Assert

class EmpresaTestCase {
	
	var Auto auto1
	var Auto auto2
	var Date fecha
	var Date fecha2 
	var Ubicacion ubic
	var Ubicacion ubic2
	var Usuario user
	var Categoria categoriaFamiliar
	var Reserva reserva
	var Empresa empre
	
	@Before
	def void setUp(){
		
	  categoriaFamiliar = new Familiar("familiar")	
	  ubic = new Ubicacion("retiro")
	   ubic2 = new Ubicacion("ezeiza")
       auto1 = new Auto("Peugeot", "505", 1990, "XXX123", categoriaFamiliar, 100D, ubic)
       auto2 = new Auto("Peugeot", "504", 1990, "XXX123", categoriaFamiliar, 100D, ubic2)
       fecha = new Date(2015-03-03)
       fecha2 = new Date(2015-03-05)
       user = new Usuario("jorge","grillo","jgrillo","mail@hotmail.com","123",new Date(10 / 11 / 1990))
       reserva = new Reserva(ubic,ubic2,fecha,fecha2,auto1,user)
       empre = new Empresa(20,12D)
	}
	
	 @Test 
     def void autosDisponibles(){
     	
     	
 	
     	empre.agregarAuto(auto1)
     	empre.agregarAuto(auto2)
     	empre.usuarios.add(user)
     	empre.agregarReserva(reserva)
   
     	Assert.assertEquals(empre.autosDisponibles(ubic,fecha).size,1)
     }
       
}