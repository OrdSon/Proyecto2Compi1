import { PlaceHolder } from './../../Instrucciones/PlaceHolder';
import { For } from 'src/Instrucciones/For';
import { While } from 'src/Instrucciones/While';
import { Else } from 'src/Instrucciones/Else';
import { If } from 'src/Instrucciones/If';
import { Asignacion } from 'src/Instrucciones/Asignacion';
import { Declaracion } from 'src/Instrucciones/Declaracion';
import { Llamada } from 'src/Instrucciones/Llamada';
import { Retorno } from 'src/Instrucciones/Retorno';
import { Detener } from 'src/Instrucciones/Detener';
import { Continuar } from 'src/Instrucciones/Continuar';
import { Funcion } from 'src/Instrucciones/Funcion';
import { Instruccion } from './../../Interfaces/Instruccion';
import { Error } from 'src/app/objects/Error';
export class Processor {
    _lineas: Array<Instruccion> = new Array();
    padres: Array<Instruccion> = new Array();
    errores: Array<Error> = new Array();
    funciones:Array<Funcion> = new Array();
    incerteza:number;
    setearEntorno() {
        console.log("setear")
        for (var instruccion of this.funciones) {
            console.log(instruccion)
        }
    }
    

    verificarEntorno() {
        var previous: Instruccion = new PlaceHolder();
        for (var instruccion of this._lineas) {
            if (instruccion.entorno > previous.entorno) {
                if (!this.isPadre(previous) && !this.isFuncion(previous)) {
                    this.errores.push(new Error(instruccion, ""));
                    return false;
                }

            }
            if (instruccion.entorno > (previous.entorno + 1)) {
                this.errores.push(new Error(instruccion, ""));
                console.log("retorne false porque algo")

                return false;
            }
            previous = instruccion;
        }
        return true;
    }

    setearPadre() {
        console.log("a ver a ver")

        if (!this.verificarEntorno()) {
            return false;
        }else{
            this.padres = [];
            this.errores = [];

        }
        for (var instruccion of this._lineas) {
            if (this.padres.length > 0) {
                if (instruccion.entorno == this.padres[this.padres.length - 1].entorno) {
                    this.padres.pop();

                }
            }
            if (this.isFuncion(instruccion)) {

                this.padres = [];
                this.padres.push(instruccion);
                this.funciones.push(instruccion as Funcion);
            }
            if (this.isPadre(instruccion) && this.padres.length > 0) {
                instruccion.padre = this.padres[this.padres.length - 1];
                this.padres.push(instruccion);
            }
            if (this.isHijo(instruccion) && this.padres.length > 0) {
                instruccion.padre = this.padres[this.padres.length - 1];
            }
        }
        return true;
    }

    isFuncion(instruccion: Instruccion) {
        if (instruccion instanceof Funcion) {
            return true;
        }
        return false;
    }
    isHijo(instruccion: Instruccion) {
        if (instruccion instanceof Continuar || instruccion instanceof Detener || instruccion instanceof Retorno) {
            return true;
        } else if (instruccion instanceof Llamada || instruccion instanceof Declaracion || instruccion instanceof Asignacion) {
            return true;
        }
        return false;
    }
    isPadre(instruccion: Instruccion) {
        if (instruccion instanceof If || instruccion instanceof Else || instruccion instanceof While || instruccion instanceof For || instruccion instanceof PlaceHolder) {
            return true;
        }
        return false;
    }


    set lineas(lineas: Array<Instruccion>) {
        this._lineas = lineas;
    }
    get lineas() {
        return this._lineas;
    }
}