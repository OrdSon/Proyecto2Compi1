import { Instruccion } from './../Interfaces/Instruccion';
export class Identificador implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    identificador:string;
    entorno: number;
    constructor(linea: Number,columna: Number,identificador:string,tab:string){
        this.linea = linea;
        this.columna = columna;
        this.identificador = identificador;        
        this.entorno = tab.length;
    }

}