

class Empleado {
	
	var property salud = 100
	
	method saludCritica()
	
	method estaIncapacitado() = salud < self.saludCritica()
	
}

class Espia inherits Empleado {
	
	override method saludCritica() = 15
}

class Oficinista inherits Empleado {
	
	var property cantidadEstrellas
	
	override method saludCritica() = 40 - 5 * cantidadEstrellas
	
}