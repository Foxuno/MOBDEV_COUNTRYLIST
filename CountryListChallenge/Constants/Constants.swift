import Foundation

enum Constants: String {
    case dummyCountry = "dummy country"
    case errorTitle = "Error"
    case errorDescription = "Algunos detalles no se han encontrado"
}

enum CountryList: String {
    case countries = "Países"
}

enum DetailView: String {
    case goToBack = "Atras"
    case capital = "Capital:"
    case region = "Región:"
    case population = "Población:"
    case flag = "Bandera:"
    case na = "N/A"
}

enum ErrorView: String {
    case errorFetch = "Ha ocurrido un error"
    case retry = "Reintentar"
}
enum Service: String {
    case url = "https://restcountries.com/v3.1/all"
    case invalidUrl = "Invalid URL"
    case noData = "No data"
}

