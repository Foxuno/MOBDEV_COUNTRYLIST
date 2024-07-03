import Foundation

class CountryListViewModel {
    private let countryService: CountryService
    private(set) var allCountries: [CountryModel] = []
    var countries: [CountryModel] = []
    
    init(countryService: CountryService) {
        self.countryService = countryService
    }
    
    func fetchCountries(completion: @escaping (Result<Void, Error>) -> Void) {
        countryService.fetchCountries { result in
            switch result {
            case .success(let countries):
                self.allCountries = countries
                self.countries = countries
                self.addDummyCountry()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func addDummyCountry() {
        let dummyName = CountryModel.Name(common: "Dummy Country", official: "Dummy Country Official")
        let dummyCountry = CountryModel(name: dummyName, capital: ["Dummy Capital"], region: "Dummy Region", population: 1000, flag: nil)
        self.allCountries.append(dummyCountry)
        self.countries.append(dummyCountry)
    }
    
    func countryHasNilValues(at index: Int) -> Bool {
        return countries[index].hasNilValues
    }
    
    func filterCountries(by searchText: String) {
        if searchText.isEmpty {
            countries = allCountries
        } else {
            countries = allCountries.filter {
                $0.name.common.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

