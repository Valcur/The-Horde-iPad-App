// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scryfallQuerry = try? newJSONDecoder().decode(ScryfallQuerry.self, from: jsonData)

import Foundation

// MARK: - ScryfallQuerry
struct ScryfallQuerry: Codable {
    let object: String
    let totalCards: Int
    let hasMore: Bool
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case object
        case totalCards
        case hasMore
        case data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let object: Object
    let id, oracleID: String
    let multiverseIDS: [Int]
    let mtgoID, arenaID, tcgplayerID, cardmarketID: Int?
    let name: String
    let lang: Lang
    let releasedAt: String
    let uri, scryfallURI: String
    let layout: Layout
    let highresImage: Bool
    let imageStatus: ImageStatus
    let imageUris: ImageUris
    let manaCost: String
    let cmc: Int
    let typeLine, oracleText: String
    let colors, colorIdentity: [Color]
    let keywords: [String]
    let producedMana: [String]?
    let allParts: [AllPart]?
    let legalities: Legalities
    let games: [Game]
    let reserved, foil, nonfoil: Bool
    let finishes: [Finish]
    let oversized, promo, reprint, variation: Bool
    let setID, datumSet, setName, setType: String
    let setURI, setSearchURI, scryfallSetURI, rulingsURI: String
    let printsSearchURI: String
    let collectorNumber: String
    let digital: Bool
    let rarity, cardBackID, artist: String
    let artistIDS: [String]
    let illustrationID: String
    let borderColor: BorderColor
    let frame: String
    let fullArt, textless, booster, storySpotlight: Bool
    let edhrecRank, pennyRank: Int?
    let prices: [String: String?]
    let relatedUris: RelatedUris
    let purchaseUris: PurchaseUris?
    let flavorText, power, toughness, securityStamp: String?
    let preview: Preview?
    let mtgoFoilID: Int?
    let frameEffects: [String]?
    let watermark: String?

    enum CodingKeys: String, CodingKey {
        case object, id
        case oracleID
        case multiverseIDS
        case mtgoID
        case arenaID
        case tcgplayerID
        case cardmarketID
        case name, lang
        case releasedAt
        case uri
        case scryfallURI
        case layout
        case highresImage
        case imageStatus
        case imageUris
        case manaCost
        case cmc
        case typeLine
        case oracleText
        case colors
        case colorIdentity
        case keywords
        case producedMana
        case allParts
        case legalities, games, reserved, foil, nonfoil, finishes, oversized, promo, reprint, variation
        case setID
        case datumSet
        case setName
        case setType
        case setURI
        case setSearchURI
        case scryfallSetURI
        case rulingsURI
        case printsSearchURI
        case collectorNumber
        case digital, rarity
        case cardBackID
        case artist
        case artistIDS
        case illustrationID
        case borderColor
        case frame
        case fullArt
        case textless, booster
        case storySpotlight
        case edhrecRank
        case pennyRank
        case prices
        case relatedUris
        case purchaseUris
        case flavorText
        case power, toughness
        case securityStamp
        case preview
        case mtgoFoilID
        case frameEffects
        case watermark
    }
}

// MARK: - AllPart
struct AllPart: Codable {
    let object, id, component, name: String
    let typeLine: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case object, id, component, name
        case typeLine
        case uri
    }
}

enum BorderColor: String, Codable {
    case black = "black"
}

enum Color: String, Codable {
    case b = "B"
    case g = "G"
    case u = "U"
    case w = "W"
}

enum Finish: String, Codable {
    case foil = "foil"
    case nonfoil = "nonfoil"
}

enum Game: String, Codable {
    case arena = "arena"
    case mtgo = "mtgo"
    case paper = "paper"
}

enum ImageStatus: String, Codable {
    case highresScan = "highres_scan"
    case lowres = "lowres"
}

// MARK: - ImageUris
struct ImageUris: Codable {
    let small, normal, large: String
    let png: String
    let artCrop, borderCrop: String

    enum CodingKeys: String, CodingKey {
        case small, normal, large, png
        case artCrop
        case borderCrop
    }
}

enum Lang: String, Codable {
    case en = "en"
}

enum Layout: String, Codable {
    case normal = "normal"
}

// MARK: - Legalities
struct Legalities: Codable {
    let standard, future, historic, gladiator: Alchemy
    let pioneer, explorer, modern, legacy: Alchemy
    let pauper, vintage, penny, commander: Alchemy
    let brawl, historicbrawl, alchemy, paupercommander: Alchemy
    let duel, oldschool, premodern: Alchemy
}

enum Alchemy: String, Codable {
    case legal = "legal"
    case notLegal = "not_legal"
    case restricted = "restricted"
}

enum Object: String, Codable {
    case card = "card"
}

// MARK: - Preview
struct Preview: Codable {
    let source: String
    let sourceURI: String
    let previewedAt: String

    enum CodingKeys: String, CodingKey {
        case source
        case sourceURI
        case previewedAt
    }
}

// MARK: - PurchaseUris
struct PurchaseUris: Codable {
    let tcgplayer, cardmarket, cardhoarder: String
}

// MARK: - RelatedUris
struct RelatedUris: Codable {
    let gatherer: String?
    let tcgplayerInfiniteArticles, tcgplayerInfiniteDecks, edhrec: String

    enum CodingKeys: String, CodingKey {
        case gatherer
        case tcgplayerInfiniteArticles
        case tcgplayerInfiniteDecks
        case edhrec
    }
}
