import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-element"
export default class extends Controller {
  static targets = ["template", "append"]

  add() {
    this.appendTarget.appendChild(this.templateTarget.content.cloneNode(true))
  }
}
