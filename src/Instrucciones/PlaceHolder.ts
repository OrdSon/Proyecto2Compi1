import { Instruccion } from './../Interfaces/Instruccion';
export class PlaceHolder implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    constructor(){
        this.linea = 0;
        this.columna = 0;
        this.entorno = 0;

    }
}