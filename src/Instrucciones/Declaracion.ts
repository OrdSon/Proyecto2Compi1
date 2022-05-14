import { Tipo } from './../Enums/Tipo';
import { Instruccion } from '../Interfaces/Instruccion';
export class Declaracion implements Instruccion{
    linea: Number;
    columna: Number;
    entorno: Number;
    padre:Instruccion;
    expresion:any;
    tipo:Tipo;
    identificador:any;
    identificadores:Array<string>;

    constructor(identificador:any, expresion:any, tipo:Tipo, identificadoes:Array<string>,linea:number,columna:number,padre:Instruccion){
        this.identificador = identificador;
        this.expresion = expresion;
        this.tipo = tipo;
        this.identificadores=identificadoes;
        this.linea = linea;
        this.columna = columna;
        this.padre = padre;
    }
}