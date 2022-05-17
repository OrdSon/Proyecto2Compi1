import { Instruccion } from './../Interfaces/Instruccion';
export class Retorno implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    valor:any;

    constructor(linea: Number,columna:Number,valor:any,entorno:string){
        this.linea = linea;
        this.columna = columna;
        this.valor = valor;
        this.entorno = entorno.length;
    }

}