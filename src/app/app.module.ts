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
import { NgbModule } from '@ng-bootstrap/ng-bootstrap'

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
