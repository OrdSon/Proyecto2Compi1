import { Instruccion } from './../Interfaces/Instruccion';
export class If implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    condicion:any;
    entorno:number;
    constructor(linea: Number,columna: Number,condicion:any,entorno:string){
        this.linea = linea;
        this.columna = columna;
        this.condicion = condicion;
        this.entorno = entorno.length;
    }
    
}