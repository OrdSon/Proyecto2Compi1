import { Instruccion } from './../Interfaces/Instruccion';
export class Incerteza implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    valor:Number;
    constructor(linea: Number,columna:Number,valor:Number,entorno:string){
        this.linea = linea;
        this.columna = columna;
        this.valor = valor;
        this.entorno = entorno.length;
    }


}