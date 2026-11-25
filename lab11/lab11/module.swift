import Foundation

struct Hero: Codable {
    let id: Int
    let name: String
    let powerstats: HeroPowerstats
    let appearance: HeroAppearance
    let biography: HeroBiography
    let images: HeroImages
}

struct HeroPowerstats: Codable {
    let intelligence: Int?
    let strength: Int?
    let speed: Int?
    let durability: Int?
    let power: Int?
    let combat: Int?
}

struct HeroAppearance: Codable {
    let gender: String?
    let race: String?
    let height: [String]?
    let weight: [String]?
}

struct HeroBiography: Codable {
    let fullName: String?
    let publisher: String?
    let alignment: String?
}

struct HeroImages: Codable {
    let xs: String?
    let sm: String?
    let md: String?
    let lg: String?
}
