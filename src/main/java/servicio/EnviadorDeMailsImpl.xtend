package servicio

import Excepciones.EnviarMailException

class EnviadorDeMailsImpl implements EnviadorDeMails{
	
	override enviarMail(Mail mail) {
        if (mail.to==""||mail.from=="") throw new EnviarMailException
    }	
}
