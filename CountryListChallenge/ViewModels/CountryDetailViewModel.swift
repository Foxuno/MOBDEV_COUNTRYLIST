import Foundation

class CountryDetailViewModel {
    let country: CountryModel
    
    var capital: String {
        return "\(DetailView.capital.rawValue) \(country.capital?.first ?? "\(DetailView.na.rawValue)")"
    }
    
    var region: String {
        return "\(DetailView.region.rawValue) \(country.region ?? "\(DetailView.na.rawValue)")"
    }
    
    var population: String {
            if let population = country.population {
                return "\(DetailView.population.rawValue) \(population.formattedWithSeparator)"
            } else {
                return "\(DetailView.population.rawValue) \(DetailView.na.rawValue)"
            }
        }

    
    var flagEmoji: String? {
        if let flag = country.flag {
            return "\(DetailView.flag.rawValue) \(flag)"
        } else {
            return "\(DetailView.flag.rawValue)"
        }
    }
    
    init(country: CountryModel) {
        self.country = country
    }
}

