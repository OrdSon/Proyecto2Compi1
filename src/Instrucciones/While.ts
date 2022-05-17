import { Instruccion } from '../Interfaces/Instruccion';
export class While implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    condicion:any;

    constructor(linea: Number,columna:Number,condicion:any,entorno:string){
        this.linea = linea;
        this.columna = columna;
        this.condicion = condicion;
        this.entorno = entorno.length;
    }

}