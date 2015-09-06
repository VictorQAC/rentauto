package Test

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement
import org.junit.Assert
import org.junit.Test
import java.sql.Date

class SistemaRYLTest {

	@Test
	def testInsert() {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement(
				"INSERT INTO Usuario (NOMBRE,APELLIDO,IDNOMBRE,PASSWORD,FECHADENACIMIENTO,EMAIL,CODIGODEVALIDACION,ESTADODEVALIDACION) VALUES (?,?,?,?,?,?,?,?)"
			);
			ps.setString(1, "pepe")
			ps.setString(2, "grillo")
			ps.setString(3, "pgrillo")
			ps.setString(4, "123")
			ps.setDate(5, new Date(10 / 11 / 1990))
			ps.setString(6, "pgrillo@hotmail.com")
			ps.setNull(7, 7)
			ps.setInt(8, 0)
			ps.execute();
			Assert.assertEquals("Se espera que haya podido insertar 1 registro", 1, ps.getUpdateCount());
			ps.close();
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}

	private def getConnection() {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/RENTAUTO?user=root&password=root");
//		return DriverManager.getConnection("jdbc:mysql://localhost/RENTAUTO?user=root&password=4278019342780554");

	}

}