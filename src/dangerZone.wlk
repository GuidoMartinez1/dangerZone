

class Mision {
	const habilidadesRequeridas = []
	const peligrosidad
	
	
	method serCumplidaPor(asignado){ //asignado puede ser tanto equipo como empleado
		self.validarHabilidades(asignado)
		asignado.recibirDanio(peligrosidad)
		asignado.finalizar(self)
	}
	
	method validarHabilidades(asignado){
		if(not self.cumpleConTodasLasHabilidadesRequeridas(asignado)){
			self.error("El asignado no puede cumplir con la mision")
		}
	}
	method cumpleConTodasLasHabilidadesRequeridas(asignado){
		habilidadesRequeridas.all({habilidad => asignado.puedeUsar(habilidad)})
	}
	
	method habilidadesQueNoPosee(empleado) =
		habilidadesRequeridas.filter({habilidad => not empleado.tiene(habilidad)})
	
	
	method enseniarHabilidades(empleado){
		self.habilidadesQueNoPosee(empleado).forEach({habilidad => empleado.aprender(habilidad)})
	}
}

class Equipo {
	const empleados = []
	
	method puedeUsar(habilidad) = empleados.any({empleado => empleado.puedeUsar(habilidad)})
	
	method recibirDanio(cantidad) {
		empleados.forEach({empleado => empleado.recibirDanio(cantidad / 3)})
	}
	
	method finalizar(mision){
		empleados.forEach({empleado => empleado.finalizar(mision)})
	}
}

class Empleado {
	
	var property salud = 100
	const habilidades = []
	var property puesto
	
	method saludCritica() = puesto.saludCritica()
	
	method estaIncapacitado() = salud < self.saludCritica()
	
	method puedeUsar(habilidad) = not self.estaIncapacitado() and self.tiene(habilidad)
	
	method tiene(habilidad) = habilidades.contains(habilidad) 
	
	method recibirDanio(cantidad){
		salud -= cantidad
	}
	
	method estaVivo() = salud > 0
	
	method finalizar(mision){
		if(self.estaVivo())
		puesto.completarMision(mision, self)
	}
	
	method aprender(habilidad){
		habilidades.add(habilidad)
	}
}

class Jefe inherits Empleado {
	const subordinados = []
	
	override method puedeUsar(habilidad) = super(habilidad) or self.algunoDeLosSubordinadosLaPuedeUsar(habilidad)
	
	method algunoDeLosSubordinadosLaPuedeUsar(habilidad) = subordinados.any({subordinado => subordinado.puedeUsar(habilidad)})
	
}


object puestoEspia  {
	
	 method saludCritica() = 15
	 
	 method completarMision(mision, empleado){
	 	mision.enseniarHabilidades(empleado)
	 }
}

class PuestoOficinista  {
	
	var property cantidadEstrellas
	
	 method saludCritica() = 40 - 5 * cantidadEstrellas
	 
	 method completarMision(mision, empleado) {
	 	cantidadEstrellas +=1
	 	if(cantidadEstrellas == 3){
	 		empleado.puesto(puestoEspia)
	 	}
	 	
	 }
	
}