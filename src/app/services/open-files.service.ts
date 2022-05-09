import { textInfo } from './../objects/text-info';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class OpenFilesService {

  constructor() {}

  files:Array<textInfo> = new Array();

}
