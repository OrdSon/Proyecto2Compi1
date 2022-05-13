
import { OpenFilesService } from './../../services/open-files.service';
import { textInfo } from './../../objects/text-info';
import { AfterViewInit, Component, ElementRef, ViewChild, Input } from '@angular/core';
import * as ace from "ace-builds";
import Swal from 'sweetalert2';

declare var GramaticaFinal:any;


@Component({
  selector: 'app-text-editor',
  templateUrl: './text-editor.component.html',
  styles: [
    `
    .app-ace-editor {
      border: 2px solid #f8f9fa;
      box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    }
  `,
  ],
})
export class TextEditorComponent implements AfterViewInit {


  @ViewChild("editor") private editor: ElementRef<HTMLElement>;
  @Input() info!: textInfo;
 
  constructor(public openFiles: OpenFilesService) {
    
  }

  ngAfterViewInit(): void {
    ace.config.set("fontSize", "14px");
    const aceEditor = ace.edit(this.editor.nativeElement);
    aceEditor.setOption("useSoftTabs",false);
    aceEditor.setOption("tabSize",4);

    if (this.info != null) {
      aceEditor.setValue(this.info.textContent);
    } else {
      aceEditor.session.setValue("NNULO");
    }
  }

  writeFile() {
  }
  
  guardarCambios(){
    const aceEditor = ace.edit(this.editor.nativeElement);
    this.info.textContent = aceEditor.getValue();
    let filter:Array<String> = ["    ","\s\s\s\s"];
  
  }
  autoDestruccion() {
    Swal.fire({
      title: '¿Estas seguro?',
      text: "¡Todos los cambios no guardados se perderan!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: '¡Cierrala!'
    }).then((result) => {
      if (result.isConfirmed) {
        let temp: number = this.info.index;
        this.openFiles.files.splice(temp, 1);
      }
    })
  }

  parsear(){
    const aceEditor = ace.edit(this.editor.nativeElement);
    let texto: String = aceEditor.session.getValue();
    let nuevo = texto.replace(/(    )/g,"\t");
    nuevo.trimEnd();
    console.log(texto.indexOf("\t"));
    console.log(texto.indexOf("\n"));
    console.log(texto.indexOf(" "));
    
    aceEditor.session.setValue(nuevo);
    GramaticaFinal.parse(aceEditor.getValue());
  }

  trimEnd(cadena:String){
    let arreglo = cadena.split("\n");
    for(let i = 0; i < arreglo.length;i++){
      
    }
  }
}
