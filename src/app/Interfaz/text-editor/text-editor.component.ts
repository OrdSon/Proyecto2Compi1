import { OpenFilesService } from './../../services/open-files.service';
import { textInfo } from './../../objects/text-info';
import { AfterViewInit, Component, ElementRef, ViewChild, Input } from '@angular/core';
import * as ace from "ace-builds";
import Swal from 'sweetalert2';
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
    aceEditor.session.setUseSoftTabs(false);
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


}
