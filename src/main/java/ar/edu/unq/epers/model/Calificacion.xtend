package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonProperty
import org.mongojack.ObjectId

@Accessors
class Calificacion {
	
	Clasificacion clasificacion
	String comentario
	Visibilidad visibilidad
	Integer idAuto
	String idUsuario
	
	@ObjectId
	@JsonProperty("_id")
	String id

    new(){}

    new(Clasificacion reseña,String comentario,Visibilidad visibilidad,Integer idAuto,String idUsuario){
    	
    	clasificacion = reseña
    	this.comentario = comentario
    	this.visibilidad = visibilidad
    	this.idAuto = idAuto
    	this.idUsuario = idUsuario
    }
}

