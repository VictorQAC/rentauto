package servicio

class Mail implements EnviadorDeMails {
	
	var String body
	var String subject
	var String to
	var String from
	
	new(String cuerpo, String asunto, String remitente, String destinatario){
		
		body = cuerpo
		subject = asunto
		to = destinatario
		from = remitente
		}
		
		override enviarMail(Mail mail) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}
		
	}