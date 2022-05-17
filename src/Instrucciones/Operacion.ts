import { Operador } from '../Enums/Operador';
import { Instruccion } from './../Interfaces/Instruccion';
export class Operacion implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;

    exprIzquierda:any;
    exprDerecha:any;
    operador:Operador;
    entorno: number;

    constructor(linea: Number,columna: Number, exprIzquierda:any,exprDerecha:any,operador:Operador,tab:string){
        this.linea = linea;
        this.columna = columna;
        this.operador = operador;
        this.exprIzquierda=exprIzquierda;
        this.exprDerecha = exprDerecha;
        this.operador = operador;
        this.entorno = tab.length;
    }
}