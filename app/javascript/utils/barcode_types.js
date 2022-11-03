export const toBackendTypes = (type) => {
  switch(type) {
    case "code_128": return "code_128"
    case "ean": return "ean_13"
    case "ean_8": return "ean_8"
    case "code_39": return "code_39"
    case "upc": return "upc_12"
    case "upc_e": return "upc_supplemental"
    case "i2of5": return "code_25_interleaved"
    case "2of5": return "code_25_iata"
    case "code_93": return "code_93"
  }

  return undefined
}
