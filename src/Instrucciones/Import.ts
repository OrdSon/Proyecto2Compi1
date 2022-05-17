import { Instruccion } from './../Interfaces/Instruccion';
export class Import implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    nombre:string;
    constructor(linea: Number,columna:Number,nombre:string,entorno:string){
        this.linea = linea;
        this.columna = columna;
        this.nombre = nombre;
        this.entorno = entorno.length;
    }


}