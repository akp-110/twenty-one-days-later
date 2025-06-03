import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="likes"
export default class extends Controller {
  static targets = ['likes']
  static values = {
    url: String,
  }

  connect() {
    this.token = document.querySelector('meta[name="csrf-token"]').content
  }

  save() {
    const url = this.urlValue
    // save the like to the db
    fetch(url, {
      method: "PATCH",
      headers: {
      'X-CSRF-Token': this.token
      }
    })
      .then((response) => response.json())
      .then((data) => {
        // update the frontend to increase the number of likes
        const existingLikes = Number.parseInt(this.likesTarget.innerText)
        this.likesTarget.innerText = `${existingLikes + 1} likes`

      })

  }
}
