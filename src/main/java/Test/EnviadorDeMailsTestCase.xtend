package Test

import org.junit.Test
import Excepciones.EnviarMailException
import servicio.EnviadorDeMailsImpl
import servicio.Mail

class EnviadorDeMailsTestCase {
	
	var EnviadorDeMailsImpl enviadorDeMail = new EnviadorDeMailsImpl()
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