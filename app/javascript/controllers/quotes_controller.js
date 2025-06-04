import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quote", "author", "message"]

  connect() {
    this.loadQuote()
  }

  async loadQuote() {
    this.messageTarget.textContent = "Loading quote..."

    try {
      const response = await fetch("/quotes/random")
      if (!response.ok) throw new Error("Network response was not ok")

      const data = await response.json()
      if (data.error) throw new Error(data.error)

      this.quoteTarget.textContent = `“${data.quote}”`
      this.authorTarget.textContent = `— ${data.author}`
      this.messageTarget.textContent = ""
    } catch (error) {
      this.messageTarget.textContent = "Sorry, we couldn't load a quote at the moment."
      this.quoteTarget.textContent = ""
      this.authorTarget.textContent = ""
      console.error("Error fetching quote:", error)
    }
  }
}
