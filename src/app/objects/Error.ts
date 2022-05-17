import { Instruccion } from './../../Interfaces/Instruccion';
export class Error{
    fallo:Instruccion;
    mensaje:String;
    constructor(fallo:Instruccion,mensaje:String){
        this.fallo = fallo;
        this.mensaje = mensaje;
    }
}