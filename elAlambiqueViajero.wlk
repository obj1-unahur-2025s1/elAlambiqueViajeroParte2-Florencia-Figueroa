object luke{
    var cantidadViajes = 0
    var recuerdo = null
    var vehiculo = alambiqueVeloz

    method cantidadViajes() = cantidadViajes 

    method viajar(lugar){
        if (lugar.puedeLlegar(vehiculo)) {
            cantidadViajes = cantidadViajes + 1
            recuerdo = lugar.recuerdoTipico()
            vehiculo.desgaste()
        }
    }
    method recuerdo() = recuerdo
    method vehiculo(nuevo) {vehiculo = nuevo}
}



//LUGARES
object paris{
    method recuerdoTipico() = "Llavero Torre Eiffel"
    method puedeLlegar(auto) =  auto.puedeFuncionar() 
    
}

object buenosAires{
    method recuerdoTipico() = "Mate"
    method puedeLlegar(auto) =  auto.rapido() 
}

object bagdad {
    var recuerdo = "bidon de petroleo"
    method recuerdoTipico() = recuerdo
    method recuerdo(nuevo) {recuerdo = nuevo }
    method puedeLlegar(auto) = true
}

object lasVegas{
    var homenaje = paris
    method homenaje(lugar) {homenaje = lugar}
    method recuerdoTipico() = homenaje.recuerdoTipico()
    method puedeLlegar(auto) = homenaje.puedeLlegar(auto)
}

object hurlingham{
    method puedeLlegar(auto) =
        auto.puedeFuncionar() and auto.rapido() and auto.patenteValida()
    method recuerdoTipico() = "sticker de la Unahur"
}



//VEHICULOS
object alambiqueVeloz {
    var combustible = 20
    const rapido = true
    const consumoPorViaje = 10
    const patente = "AB123JK"

    method puedeFuncionar() = combustible >= consumoPorViaje
    method desgaste() {combustible = combustible - consumoPorViaje}
    method rapido() = rapido
    method patenteValida() = patente.head() == "A"
    method velocidad() = combustible * 1.5
}

object antigualla {
  const gangsters = ["mario", "marco", "chincho", "brian", "florencia", "amelie", "pablo"]

  method rapido(){}
  method puedeFuncionar() = gangsters.size().even()
  method patenteValida() = chatarra.rapido() 
  method desgaste() {gangsters.remove(gangsters.last())}
  method velocidad() = gangsters.fold(0, {acum,gangsters => acum + gangsters.length()})

  method bajarDelAuto(unGangster) = gangsters.remove(unGangster)
  method subirAlAuto(unGangster) = gangsters.add(unGangster)
}

object superPerrati {
    var velocidad = 50

    method rapido() = true
    method patenteValida()= true
    method desgaste(){velocidad = velocidad - 2}
    method puedeFuncionar() = velocidad > 0
    method velocidad() = velocidad
    method hacerTrampa(){velocidad = velocidad - 10}
}


object chatarra {
    var cañones = 10
    var municiones = "ACME"
    const velocidad = 100

    method cañones() = cañones
    method rapido() = municiones.size() < cañones
    method patenteValida() = municiones.take(4) == "ACME" 
    method puedeFuncionar() = municiones == "ACME" and cañones.between(6,12)
    method velocidad() = velocidad * cañones
    method desgaste(){ cañones = (cañones / 2).roundUp(0)
                       if (cañones < 5 ) municiones = municiones + " Obsoleto"
    }    
}

object convertible{
    var posicionActual = 0
    var convertido = chatarra
    const autosAConvertir = [chatarra, alambiqueVeloz, antigualla, moto]

    method rapido() = convertido.rapido()
    method puedeFuncionar() = convertido.puedeFuncionar()
    method patenteValida() = convertido.patenteValida()
    method desgaste() = convertido.desgaste()
    method velocidad() = convertido.velocidad()

    method autoActual() = convertido
    method convertirEn(vehiculo){convertido = vehiculo}
    method convertirse() {
        posicionActual = posicionActual + 1
        convertido = autosAConvertir.get(posicionActual)
    }
}

object moto{
    method rapido() = true
    method puedeFuncionar() = not self.rapido()
    method desgaste() {}
    method patenteValida() = false
    method velocidad() = 5
}



//CENTRO DE INSCRIPCIONES - CARRERA
object carrera {
    var lugarCarrera = paris
    const vehiculosIncriptos = []
    const vehiculosRechazados = []

    method asignarCuidad(unLugar){lugarCarrera = unLugar} 

    method verificarInscripcion(vehiculo){
        if(lugarCarrera.puedeLlegar(vehiculo)) 
            vehiculosIncriptos.add(vehiculo)
        else 
            vehiculosRechazados.add(vehiculo)
        
    }
    method inscriptosEnCarrera() = vehiculosIncriptos
    method replanificacionEn(unLugar) {
      lugarCarrera = unLugar
      vehiculosIncriptos.forEach{i => self.verificarInscripcion(i)}
      vehiculosRechazados.forEach{r => self.verificarInscripcion(r)}
    }
    method viajar(){
        vehiculosIncriptos.forEach({v => v.desgaste()})
    }

    method ganador() =
        vehiculosIncriptos.max({v => v.velocidad()})
}