import { Tipo } from './../Enums/Tipo';
import { Instruccion } from '../Interfaces/Instruccion';
export class Declaracion implements Instruccion{
    linea: Number;
    columna: Number;
    padre:Instruccion;
    expresion:any;
    tipo:Tipo;
    identificador:any;
    identificadores:Array<string>;

    constructor(identificador:any, expresion:any, tipo:Tipo, identificadoes:Array<string>,linea:number,columna:number,tab:string){
        this.identificador = identificador;
        this.expresion = expresion;
        this.tipo = tipo;
        this.identificadores=identificadoes;
        this.linea = linea;
        this.columna = columna;
        this.entorno = tab.length;
    }
    entorno: number;
}