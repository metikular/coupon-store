import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-element"
export default class extends Controller {
  removeSelf() {
    this.element.remove()
  }
}
