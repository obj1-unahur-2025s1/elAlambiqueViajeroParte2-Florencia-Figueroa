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
    method puedeLlegar(movil) =  movil.puedeFuncionar() 
    
}

object buenosAires{
    method recuerdoTipico() = "Mate"
    method puedeLlegar(auto) =  auto.rapido() 
}

object bagdad {
    var recuerdo = "bidon de petroleo"
    method recuerdoTipico() = recuerdo
    method recuerdo(nuevo) {recuerdo = nuevo }
    method puedeLlegar(cualquierCosa) = true
}

object lasVegas{
    var homenaje = paris
    method homenaje(lugar) {homenaje = lugar}
    method recuerdoTipico() = homenaje.recuerdoTipico()
    method puedeLlegar(vehiculo) = homenaje.puedeLlegar(vehiculo)
}

object hurlingham{
   method puedeLlegar(vehiculo) =
     vehiculo.puedeFuncionar() and vehiculo.rapido() and vehiculo.patenteValida()
  method recuerdoTipico() = "sticker de la Unahur"
}



//VEHICULOS

object alambiqueVeloz {
    const rapido = true
    var combustible = 20
    const consumoPorViaje = 10
    const patente = "AB123JK"
    method puedeFuncionar() = combustible >= consumoPorViaje
    method desgaste() {
        combustible = combustible - consumoPorViaje
    }
    method rapido() = rapido
    method patenteValida() = patente.head() == "A"
}

object antigualla {
  const gangsters = ["mario", "marco", "chincho", "brian", "florencia", "amelie", "pablo"]
  method esRapido() = gangsters.fold(0,{acum,gangster => acum + gangster.length()}) < 24
  method puedeFuncionar() = gangsters.even()
  method desgaste() {
    gangsters.remove(gangsters.last())
  }
  method bajarDelAuto(unGangster) = gangsters.remove(unGangster)
  method subirAlAuto(unGangster) = gangsters.add(unGangster)
  method patenteValida() = chatarra.rapido() 
}
/*
El vehículo conducido por Pierre Nodoyuna y Patán si bien es más rápido que muchos otros, siempre intentan hacer 
trampas o perjudicar a los otros corredores y terminan tardando más en llegar a la meta.
*/
object chatarra {
    var cañones = 10
    var municiones = "ACME"
    method puedeFuncionar() = municiones == "ACME" and cañones.between(6,12)
    method rapido() = municiones.size() < cañones
    method desgaste(){
        cañones = (cañones / 2).roundUp(0)
        if (cañones < 5 )
          municiones = municiones + " Obsoleto"
    }
    method patenteValida() = municiones.take(4) == "ACME" 
    method cañones() = cañones
}

object convertible{
    var posicionActual = 0
    var convertido = chatarra
    const autosAConvertir = [chatarra, alambiqueVeloz, antigualla, moto]
    method autoActual() = convertido
    method puedeFuncionar() = convertido.puedeFuncionar() 
    method rapido() = convertido.rapido()
    method desgaste() = convertido.desgaste()
    method convertirse() {
        posicionActual = posicionActual + 1
        convertido = autosAConvertir.get(posicionActual)
    }
    method convertirEn(vehiculo){
        convertido = vehiculo
    }
    method patenteValida() = convertido.patenteValida()
 
}

object moto{
    method rapido() = true
    method puedeFuncionar() = not self.rapido()
    method desgaste() { }
    method patenteValida() = false
}



//CENTRO DE INSCRIPCIONES

object centro {
    var lugarCarrera = paris
    const vehiculosIncriptos = #{}
    const rechazados = #{}

    method verificar(vehiculo){
        if(lugarCarrera.puedeLlegar(vehiculo)){
            vehiculosIncriptos.add(vehiculo)
        }
        else{
            rechazados.add(vehiculo)
        }
    }

    method replanificacionEn(unLugar) {
      lugarCarrera = unLugar
      vehiculosIncriptos.forEach{inscripto => self.verificar(inscripto)}
      rechazados.forEach{rechazado => self.verificar(rechazado)}
    }
}

