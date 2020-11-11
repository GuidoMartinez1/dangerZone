

class Empleado {
	
	var property salud = 100
	const habilidades = []
	var puesto
	
	method saludCritica() = puesto.saludCritica()
	
	method estaIncapacitado() = salud < self.saludCritica()
	
	method puedeUsar(habilidad) = not self.estaIncapacitado() and self.tiene(habilidad)
	
	method tiene(habilidad) = habilidades.contains(habilidad) 
}

class Jefe inherits Empleado {
	const subordinados = []
	
	override method puedeUsar(habilidad) = super(habilidad) or self.algunoDeLosSubordinadosLaPuedeUsar(habilidad)
	
	method algunoDeLosSubordinadosLaPuedeUsar(habilidad) = subordinados.any({subordinado => subordinado.puedeUsar(habilidad)})
	
}


object puestoEspia  {
	
	 method saludCritica() = 15
}

class PuestoOficinista  {
	
	var property cantidadEstrellas
	
	 method saludCritica() = 40 - 5 * cantidadEstrellas
	
}