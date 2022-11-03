import { Controller } from "@hotwired/stimulus"
import Quagga from '@ericblade/quagga2'

// Connects to data-controller="barcode-reader"
export default class extends Controller {
  connect() {
    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        target: this.element
      },
      decoder : {
        readers : [
          //TODO: specifying all barcodes here results in detection of the wrong barcode type
          "code_128_reader",
          "ean_reader",
          "ean_8_reader",
          //"code_39_reader",
          //"code_39_vin_reader",
          //"codabar_reader",
          //"upc_reader",
          //"upc_e_reader",
          //"i2of5_reader",
          //"2of5_reader",
          //"code_93_reader",
          //"code_32_reader"
        ]
      }
    }, function(err) {
        if (err) {
            console.log(err);
            return
        }
        console.log("Initialization finished. Ready to start");
        Quagga.start();

        Quagga.onDetected((data) => {
          console.log('detected', data)
        })
    });
  }
}
