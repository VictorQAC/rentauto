package ar.edu.unq.epers.servicio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mail{
	
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
		
	new(){}
	
	
}