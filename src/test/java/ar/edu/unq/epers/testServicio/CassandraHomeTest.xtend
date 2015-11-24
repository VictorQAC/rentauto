package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.home.CassandraHome
import org.junit.Before
import org.junit.Test
import java.lang.reflect.Array

class CassandraHomeTest {
	
	var CassandraHome cs
	var Array[]         strings
	
	
	@Before
	def void setUp(){
		
		cs = new CassandraHome()
		strings = Array(String)
		
	}
	
	
	@Test
	def void probarCreacionDeTablaTest(){
	
	cs.main(strings)
	
	}	
	
}