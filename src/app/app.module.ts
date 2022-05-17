
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavBarComponent } from './Interfaz/nav-bar/nav-bar.component';
import { SideBarComponent } from './Interfaz/nav-bar/side-bar/side-bar.component';
import { TabComponent } from './Interfaz/tab/tab.component';
import { TextEditorComponent } from './Interfaz/text-editor/text-editor.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatTabsModule} from '@angular/material/tabs';
import { TerminalComponent } from './Interfaz/terminal/terminal.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { Declaracion } from 'src/Instrucciones/Declaracion';
import { Asignacion } from 'src/Instrucciones/Asignacion';
import { Identificador } from './../Instrucciones/Identificador';
import { Llamada } from 'src/Instrucciones/Llamada';
import { Operacion } from 'src/Instrucciones/Operacion';
import { Primitivo } from 'src/Instrucciones/Primitivo';
import { Tipo } from 'src/Enums/Tipo';
import { Funcion } from 'src/Instrucciones/Funcion';
import { For } from 'src/Instrucciones/For';
import { If } from 'src/Instrucciones/If';
import { Else } from 'src/Instrucciones/Else';
import { Import } from 'src/Instrucciones/Import';
import { Incerteza } from 'src/Instrucciones/Incerteza';
import { Detener } from 'src/Instrucciones/Detener';
import { Continuar } from 'src/Instrucciones/Continuar';
import { While } from 'src/Instrucciones/While';
import { Retorno } from 'src/Instrucciones/Retorno';
@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    SideBarComponent,
    TabComponent,
    TextEditorComponent,
    TerminalComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatTabsModule,
    NgbModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
