package ar.edu.unq.epers.home

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.Host

 class SimpleClient {
	
	/*Cluster cluster1 = Cluster.builder().addContactPoints("10.9.1.231").build()
	
	Session sesion = cluster1.connect()
	
	sesion.execute("CREATE KEYSPACE prueba " + 
	"WITH replication = " + 
	"{ 'class' : 'SimpleStrategy', 'replication_factor' : 1 }")*/
	
	
   Cluster cluster;

   def void connect(String node) {
      cluster = Cluster.builder().addContactPoint(node).build();
      Metadata metadata = cluster.getMetadata();
      System.out.printf("Connected to cluster: %s\n", 
            metadata.getClusterName());
      for ( Host host : metadata.getAllHosts() ) {
         System.out.printf("Datacenter: %s; Host: %s; Rack: %s\n",
               host.getDatacenter(), host.getAddress(), host.getRack());
      }
   }

   def void close() {
      cluster.shutdown();
   }

   def void main(String[] args) {
   SimpleClient client = new SimpleClient();
      client.connect("127.0.0.1");
      client.close();
   }
}
	
 	
