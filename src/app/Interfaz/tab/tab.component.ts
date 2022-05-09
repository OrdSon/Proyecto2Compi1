import Swal  from 'sweetalert2';
import { OpenFilesService } from './../../services/open-files.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-tab',
  templateUrl: './tab.component.html',
  styleUrls: ['./tab.component.css']
})
export class TabComponent implements OnInit {

  constructor(public openFiles:OpenFilesService) { }

  ngOnInit(): void {
  }
  saludar(){
    Swal.fire(this.openFiles.files.length+"")
  }
}
