package ar.edu.unq.epers.model

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.mapping.Mapper
import org.junit.Before
import com.datastax.driver.mapping.MappingManager
import org.junit.Test
import org.junit.Assert
import org.junit.After

class ModelTest {
	Cluster cluster
	Session session
	Mapper<AutosDisponibles> mapper
	AutosDisponibles autosDisponibles1
	AutosDisponibles autosDisponibles2
	AutoCache autoCache1
	AutoCache autoCache2
	AutoCache autoCache3
	AutoCache autoCache4
	AutoCache autoCache5

	@Before
	def void setup() {
		connect
		createSchema
		crearBusqueda
	}

	

	@After
	def eliminarTablas() {
		session.execute("DROP KEYSPACE IF EXISTS simplex");
		cluster.close();
	}

	def createSchema() {
		session.execute("CREATE KEYSPACE IF NOT EXISTS  simplex WITH replication = {'class':'SimpleStrategy', 'replication_factor':3};")

		session.execute("CREATE TYPE IF NOT EXISTS simplex.autoCache (" +
			"patente text," + 
			"ubicacionInicial text);"
		)

		session.execute("CREATE TABLE IF NOT EXISTS simplex.autosDisponibles (" + 
				"dia text, " +
				"ubicacion text, " +
				"autos list< frozen<autoCache>>," + 
				"PRIMARY KEY (dia, ubicacion));"
		)
		mapper = new MappingManager(session).mapper(AutosDisponibles);
	}

	def connect() {
		cluster = Cluster.builder().addContactPoint("localhost").build();
		session = cluster.connect();
	}
	
	
	def void crearBusqueda() {
		autoCache1 = new AutoCache => [
			patente = "abc123"
			
		]

		autoCache2 = new AutoCache => [
			patente = "abc456"
		
			
		]

		autoCache3 = new AutoCache => [
			patente = "abc789"
			
		]

		autoCache4 = new AutoCache => [
			patente = "def123"
			
		]

		autoCache5 = new AutoCache => [
			patente = "def456"
			
		]

		autosDisponibles1 = new AutosDisponibles => [
		
			dia = "10/05/2015"
			ubicacion = "tandil"
			autos = #[autoCache1, autoCache3, autoCache5]
		]
		
		autosDisponibles2 = new AutosDisponibles => [
			
			dia = "12/05/2015"
			ubicacion = "azul"
			autos = #[autoCache2, autoCache4]
		]
		mapper.save(autosDisponibles1)
		mapper.save(autosDisponibles2)
	}
	
	
	@Test
	def obtenerBusqueda() {
		val busqueda = mapper.get("10/05/2015","tandil")
		Assert.assertEquals(busqueda.ubicacion, "tandil")
		Assert.assertEquals(busqueda.dia, "10/05/2015")
		Assert.assertTrue(busqueda.autos.containsAll(#[autoCache1, autoCache3, autoCache5]))
		Assert.assertEquals(busqueda.autos.length,3)
	}
	
}
	