package ar.edu.unq.epers.model

class Calificacion {
	
	Clasificacion clasificacion
	String comentario
	Visibilidad visibilidad
	Integer idAuto
	String idUsuario

    new(Clasificacion reseña,String comentario,Visibilidad visibilidad,Integer idAuto,String idUsuario){
    	
    	clasificacion = reseña
    	this.comentario = comentario
    	this.visibilidad = visibilidad
    	this.idAuto = idAuto
    	this.idUsuario = idUsuario
    }
}

