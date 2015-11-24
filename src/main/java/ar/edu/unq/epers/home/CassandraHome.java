package ar.edu.unq.epers.home;


import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.Host;



public class CassandraHome{
	
	  private Cluster cluster;
	  private Session session;
	  
	  
	   public void connect(String node) {
	      cluster = Cluster.builder().addContactPoint(node).build();
	      Metadata metadata = cluster.getMetadata();
	      System.out.printf("Connected to cluster: %s\n", 
	            metadata.getClusterName());
	      for ( Host host : metadata.getAllHosts() ) {
	         System.out.printf("Datacenter: %s; Host: %s; Rack: %s\n",
	               host.getDatacenter(), host.getAddress(), host.getRack());
	      }
	      

		  session = cluster.connect();
	   }

	   private void close() {
	      cluster.close();
	   }

	   public static void main(String[] args) {
		  CassandraHome client = new  CassandraHome();
	      client.connect("127.0.0.1");
	      client.close();
	   }
	   
	   public void createSchema() { 
		   
		   session.execute("CREATE KEYSPACE simplex WITH replication " + 
				      "= {'class':'SimpleStrategy', 'replication_factor':3};");
	   }
	   
	   public void createTable(){
		   
		   session.execute(
				      "CREATE TABLE simplex.songs (" +
				            "id uuid PRIMARY KEY," + 
				            "title text," + 
				            "album text," + 
				            "artist text," + 
				            "tags set<text>," + 
				            "data blob" + 
				            ");");
	   }
}
 


