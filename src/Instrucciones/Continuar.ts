import { Instruccion } from './../Interfaces/Instruccion';
export class Continuar implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    constructor(linea: Number,columna:Number,entorno:string){
        this.linea = linea;
        this.columna = columna;
        this.entorno = entorno.length;
    }
}