import { Instruccion } from './../Interfaces/Instruccion';
export class Operacion implements Instruccion{
    linea: Number;
    columna: Number;
    entorno: Number;
    padre: Instruccion;

}