import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { Component, OnInit, AfterViewInit, ViewChild, ElementRef } from '@angular/core';
import * as ace from "ace-builds";

@Component({
  selector: 'app-terminal',
  templateUrl: './terminal.component.html',
  styleUrls: ['./terminal.component.css']
})
export class TerminalComponent implements AfterViewInit {
  @ViewChild("editor") private editor: ElementRef<HTMLElement>;
  constructor() { }
  ngOnInit(): void {
  }
  public isCollapsed = true;
  buttonText: String;

  ngAfterViewInit(): void {
    ace.config.set("fontSize", "14px");
    const aceEditor = ace.edit(this.editor.nativeElement);

  }

  readFileContent() {
    fetch('something.txt')
      .then(response => response.text())
      .then(data => {
        // Do something with your data
        console.log(data);
      });
  }

  
}
