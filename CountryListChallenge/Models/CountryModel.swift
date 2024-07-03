import Foundation

struct CountryModel: Decodable {
    let name: Name
    let capital: [String]?
    let region: String?
    let population: Int?
    let flag: String?
    
    struct Name: Decodable {
        let common: String
        let official: String
    }
}

extension CountryModel {
    var hasNilValues: Bool {
        return capital?.first == nil || region == nil || population == nil || flag == nil
    }
}

