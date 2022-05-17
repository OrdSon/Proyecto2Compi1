import { Declaracion } from './Declaracion';
import { Instruccion } from './../Interfaces/Instruccion';
import { Tipo } from 'src/Enums/Tipo';
export class Funcion implements Instruccion {
    linea: Number;
    columna: Number;
    padre: Instruccion;
    nombre: string;
    parametros: Array<Declaracion>;
    tipo: Tipo;
    constructor(linea: Number, columna: Number, nombre: string, parametros: Array<Declaracion>, tipo: Tipo,tab:string) {
        this.linea = linea;
        this.columna = columna;
        this.nombre = nombre;
        this.parametros = parametros;
        this.tipo = tipo;
        this.entorno = tab.length;
    }
    entorno: number;

}