import { Component } from '@angular/core';
import { AppService } from './app.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'cloud-application';

  constructor(public service: AppService){}

  createCluster(){
    console.log("hello")
    this.service.createCluster();
  }
}
