import { Operador } from './../Enums/Operador';
import { Instruccion } from './../Interfaces/Instruccion';
export class For implements Instruccion {
    linea: Number;
    columna: Number;
    padre: Instruccion;
    entorno: number;
    variable:any;
    condicion:any;
    operador:Operador;
    constructor(linea: Number, columna: Number,variable:any,condicion:any,operador:Operador, entorno: string) {
        this.linea = linea;
        this.columna = columna;
        this.entorno = entorno.length;
    }
}