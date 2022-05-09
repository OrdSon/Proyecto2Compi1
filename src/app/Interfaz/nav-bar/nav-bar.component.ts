import { textInfo } from './../../objects/text-info';
import { OpenFilesService } from './../../services/open-files.service';
import { Component, OnInit } from '@angular/core';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

  constructor(public openfiles: OpenFilesService) {

  }

  ngOnInit(): void {
  }
  newDocument() {
    console.log("funcion nuevo documento")
    Swal.fire({
      title: 'Nombre del nuevo documento',
      text:'¡No olvides la extension!',
      input: 'text',
      inputAttributes: {
        autocapitalize: 'off'
      },
      showCancelButton: true,
      confirmButtonText: '¡Crear!',
      cancelButtonText:'Cancelar',
      showLoaderOnConfirm: true,
      preConfirm: (name) => {
        let temp: textInfo = new textInfo()
        temp.index = this.openfiles.files.length;
        temp.textContent = "";
        temp.textName = name;
        this.openfiles.files.push(temp);
      },
      allowOutsideClick: () => !Swal.isLoading()
    })
  }


  file: File;
  fileChanged(e: any) {
    this.file = e.target.files[0];
    let fileReader: FileReader = new FileReader();
    if (this.file) {
      fileReader.onload = (e) => {
        let texto = "";
        texto += fileReader.result;
        let text_info: textInfo = new textInfo();
        text_info.index = this.openfiles.files.length;
        text_info.textName = this.file.name;
        text_info.textContent = texto;
        this.openfiles.files.push(text_info);
      }
      fileReader.readAsText(this.file);
    }

  }

}
