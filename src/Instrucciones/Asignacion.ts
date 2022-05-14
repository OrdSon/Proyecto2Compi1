import { Instruccion } from './../Interfaces/Instruccion';

export class Asignacion {
    linea: number;
    columna: number;
    expresion: Instruccion;
    identificador: string;
    padre: Instruccion;
    constructor(linea: number, columna: number, expresion: any, identificador: string, padre: Instruccion) {
        this.linea = linea;
        this.columna = columna;
        this.expresion = expresion;
        this.identificador = identificador;
        this.padre = padre
    }   

}
