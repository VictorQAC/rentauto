package ar.edu.unq.epers.model

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Auto {
	public String marca
	public String modelo
	public Integer anio
	public String patente
	public Double costoBase
	public Integer id
	Categoria categoria
	
	
	//Debe estar ordenado
	List<Reserva> reservas = newArrayList()
	Ubicacion ubicacionInicial
	
	new(){}

	new(String marca, String modelo, Integer anio, String patente, Double costoBase,Ubicacion ubicacionInicial,Categoria categoria){
		this.marca = marca
		this.modelo = modelo
		this.anio = anio
		this.patente = patente
		this.costoBase = costoBase
		this.categoria = categoria
		this.ubicacionInicial = ubicacionInicial
	}
/* 
	def getUbicacion(){
		this.ubicacionParaDia(new Date());
	}
	
	def ubicacionParaDia(Date unDia){
		val encontrado = reservas.findLast[ it.fin <= unDia ]
		if(encontrado != null){
			return encontrado.destino
		}else{
			return ubicacionInicial
		}
	}
	
	def Boolean estaLibre(Date desde, Date hasta){
		reservas.forall[ !seSuperpone(desde,hasta) ]
	}
	
	def agregarReserva(Reserva reserva){
		reserva.validar
		reservas.add(reserva)
		reservas.sortInplaceBy[inicio]
	}
	
	def costoTotal(){
		return categoria.calcularCosto(this)
	}
	*/
}
