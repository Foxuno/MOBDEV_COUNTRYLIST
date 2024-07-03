import Foundation

class CountryService {
    func fetchCountries(completion: @escaping (Result<[CountryModel], Error>) -> Void) {
        let urlString = Service.url.rawValue
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: Service.invalidUrl.rawValue, code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: Service.noData.rawValue, code: 0, userInfo: nil)))
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([CountryModel].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

