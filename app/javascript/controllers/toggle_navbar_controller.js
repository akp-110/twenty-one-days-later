import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-navbar"
export default class extends Controller {
  static targets = ["sidebar"]
  connect() {
    console.log("Hello world")
  }

  close() {
    this.sidebarTarget.style.width = "0";
  }

  open() {
    this.sidebarTarget.style.width = "250px";
  }
}
