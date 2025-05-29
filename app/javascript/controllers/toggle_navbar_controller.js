import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-navbar"
export default class extends Controller {
  static targets = ["sidebar", "main", "open"]
  connect() {
    console.log("Hello world")
  }
  close() {
    this.sidebarTarget.style.display = "none"
    this.mainTarget.style.marginLeft = "0"
    this.openTarget.style.display = "block"
  }

  open() {
    this.sidebarTarget.style.display = "block"
    this.mainTarget.style.marginLeft = "250px"
    this.openTarget.style.display = "none"
  }
}
