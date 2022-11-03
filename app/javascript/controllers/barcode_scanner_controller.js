import { Controller } from "@hotwired/stimulus"
import Quagga from "@ericblade/quagga2"
import { toBackendTypes } from "utils/barcode_types"

// Connects to data-controller="barcode-scanner"
export default class extends Controller {
  static targets = ["modal", "camera", "list"]

  static values = {
    barcodeUrl: String
  }

  connect() {
    this.deactivate()
  }

  activate() {
    this.modalTarget.style.display = 'inherit'
    this.start()
  }

  deactivate() {
    this.modalTarget.style.display = 'none'
  }

  start() {
    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        target: this.cameraTarget
      },
      locator: {
        debug: {
          showCanvas: true
        }
      },
      decoder : {
        readers : [
          "code_128_reader",
          "ean_reader",
          "ean_8_reader",
          "code_39_reader",
          //"code_39_vin_reader",
          //"codabar_reader",
          "upc_reader",
          "upc_e_reader",
          "i2of5_reader",
          "2of5_reader",
          "code_93_reader",
          //"code_32_reader",
        ]
      }
    }, (error) => {
        if (error) {
            console.error(error);
            return
        }

        Quagga.start();

        Quagga.onDetected((data) => {
          const code = data.codeResult.code
          const format = toBackendTypes(data.codeResult.format)
          const id = `barcode_${format}_${code}`

          if (!format) return

          if (this.listTarget.querySelector(`[data-code="${code}"][data-type="${format}"]`)) {
            return
          }

          const barcodeImageUrl = new URL(this.barcodeUrlValue, window.location.href)
          barcodeImageUrl.searchParams.set('type', format)
          barcodeImageUrl.searchParams.set('code', code)

          const turboFrame = document.createElement('turbo-frame')
          turboFrame.id = id
          turboFrame.src = barcodeImageUrl.href

          this.listTarget.append(turboFrame)
        })
    });
  }

  choose(event) {
    const element = event.target.closest('[data-code]')
    const code = element.dataset.code
    const type = element.dataset.type

    document.getElementById('coupon_code').value = code
    document.getElementById('coupon_barcode_type').value = type

    this.deactivate()
  }
}
