import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="barcode-preview"
export default class extends Controller {
  static targets = ["modal", "input"]

  connect() {
    this.modalTarget.style.display = 'inherit'
  }

  close() {
    this.modalTarget.style.display = 'none'
  }

  choose(event) {
    let barcodeType = event.currentTarget.dataset.barcodeType

    this.inputTarget.value = barcodeType
    this.close()
  }
}
