import { Tipo } from './../Enums/Tipo';
import { Instruccion } from './../Interfaces/Instruccion';
export class Llamada implements Instruccion{
    linea: Number;
    columna: Number;
    padre: Instruccion;
    valor:any;
    tipo:Tipo;
    nombre:string;
    entorno: number;
    argumentos:Array<any>;
    constructor(linea: Number,columna: Number,nombre:string,argumantos:Array<any>,tab:string){
        this.linea = linea;
        this.columna = columna;
        this.nombre = nombre;
        this.entorno = tab.length;
        this.argumentos = argumantos;
    }
}