package ar.edu.unq.epers.testServicio

import org.junit.Test
import ar.edu.unq.epers.servicio.Mail
import ar.edu.unq.epers.excepciones.EnviarMailException
import ar.edu.unq.epers.servicio.EnviadorDeMails

class EnviadorDeMailsTestCase {
	
	var EnviadorDeMails enviadorDeMail
	var Mail mail
	
	@Test
    (expected = EnviarMailException)def void testMailFallando(){
        mail = new Mail("","","","")

        enviadorDeMail.enviarMail(mail)
    }

    @Test def void testMailAndando(){
        mail = new Mail("cuerpo","asunto","usuario","sistema")

        enviadorDeMail.enviarMail(mail)
    }
}