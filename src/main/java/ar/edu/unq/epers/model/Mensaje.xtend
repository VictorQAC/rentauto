package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mensaje {
	var String texto
	
	new(){}
	
	new(String unTexto){
		texto = unTexto;
	}
	
}