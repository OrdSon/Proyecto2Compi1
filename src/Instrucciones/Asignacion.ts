import { Instruccion } from './../Interfaces/Instruccion';

export class Asignacion implements Instruccion {
    linea: number;
    columna: number;
    expresion: Instruccion;
    identificador: string;
    padre: Instruccion;
    constructor(linea: number, columna: number, expresion: any, identificador: string,tab:string) {
        this.linea = linea;
        this.columna = columna;
        this.expresion = expresion;
        this.identificador = identificador;
        this.entorno = tab.length;
    }   
    entorno: number;

}
