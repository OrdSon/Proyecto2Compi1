import { Tipo } from 'src/Enums/Tipo';
import { Instruccion } from './../Interfaces/Instruccion';
export class Primitivo implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    valor:any;  
    tipo:Tipo;
    entorno: number;
    constructor(linea:Number, columna:Number,valor:any,tipo:Tipo,tab:string){
        this.linea = linea;
        this.columna=columna;
        this.valor = valor;
        this.tipo = tipo;
        this.entorno = tab.length;
    }
}