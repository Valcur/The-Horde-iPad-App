// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scryfallQuerry = try? newJSONDecoder().decode(ScryfallQuerry.self, from: jsonData)

import Foundation

// MARK: - ScryfallQuerry
struct ScryfallQuerry: Codable {
    let object: String?
    let totalCards: Int?
    let hasMore: Bool?
    let nextPage: String?
    let data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case object
        case totalCards
        case hasMore
        case nextPage
        case data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let object: DatumObject?
    let id, oracleID: String?
    let multiverseIDS: [Int]?
    let mtgoID, arenaID, tcgplayerID, cardmarketID: Int?
    let name: String?
    let lang: String?
    let releasedAt: String?
    let uri, scryfallURI: String?
    let layout: Layout?
    let highresImage: Bool?
    let imageStatus: ImageStatus?
    let imageUris: ImageUris?
    let mana_cost: String?
    let cmc: Int?
    let type_line, oracleText: String?
    let colors, colorIdentity: [ColorIdentity]?
    let keywords: [String]?
    let legalities: Legalities?
    let games: [Game]?
    let reserved, foil, nonfoil: Bool?
    let finishes: [Finish]?
    let oversized, promo, reprint, variation: Bool?
    let setID, set, setName: String?
    let setType: SetType?
    let setURI, setSearchURI, scryfallSetURI, rulingsURI: String?
    let printsSearchURI: String?
    let collectorNumber: String?
    let digital: Bool?
    let rarity: Rarity?
    let flavorText, cardBackID, artist: String?
    let artistIDS: [String]?
    let illustrationID: String?
    let borderColor: BorderColor?
    let frame: String?
    let fullArt, textless, booster, storySpotlight: Bool?
    let edhrecRank: Int?
    let preview: Preview?
    let prices: [String: String?]?
    let relatedUris: RelatedUris?
    let purchaseUris: PurchaseUris?
    let power, toughness: String?
    let allParts: [AllPart]?
    let securityStamp: SecurityStamp?
    let cardFaces: [CardFace]?
    let watermark: String?
    let frameEffects: [String]?
    let mtgoFoilID: Int?
    let producedMana: [ColorIdentity]?
    let pennyRank: Int?
    let promoTypes: [String]?

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
        case mana_cost
        case cmc
        case type_line
        case oracleText
        case colors
        case colorIdentity
        case keywords, legalities, games, reserved, foil, nonfoil, finishes, oversized, promo, reprint, variation
        case setID
        case set
        case setName
        case setType
        case setURI
        case setSearchURI
        case scryfallSetURI
        case rulingsURI
        case printsSearchURI
        case collectorNumber
        case digital, rarity
        case flavorText
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
        case preview, prices
        case relatedUris
        case purchaseUris
        case power, toughness
        case allParts
        case securityStamp
        case cardFaces
        case watermark
        case frameEffects
        case mtgoFoilID
        case producedMana
        case pennyRank
        case promoTypes
    }
}

// MARK: - AllPart
struct AllPart: Codable {
    let object: AllPartObject?
    let id: String?
    let component: Component?
    let name, typeLine: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case object, id, component, name
        case typeLine
        case uri
    }
}

enum Component: String, Codable {
    case comboPiece = "combo_piece"
    case token = "token"
}

enum AllPartObject: String, Codable {
    case relatedCard = "related_card"
}

enum BorderColor: String, Codable {
    case black = "black"
    case borderless = "borderless"
    case silver = "silver"
    case white = "white"
}

// MARK: - CardFace
struct CardFace: Codable {
    let object, name, mana_cost, typeLine: String?
    let oracleText: String?
    let colors: [ColorIdentity]?
    let power, toughness, artist, artistID: String?
    let illustrationID: String?
    let imageUris: ImageUris?
    let flavorName, flavorText: String?
    let colorIndicator: [ColorIdentity]?

    enum CodingKeys: String, CodingKey {
        case object, name
        case mana_cost
        case typeLine
        case oracleText
        case colors, power, toughness, artist
        case artistID
        case illustrationID
        case imageUris
        case flavorName
        case flavorText
        case colorIndicator
    }
}

enum ColorIdentity: String, Codable {
    case b = "B"
    case c = "C"
    case g = "G"
    case r = "R"
    case u = "U"
    case w = "W"
    case m = "M"
}

// MARK: - ImageUris
struct ImageUris: Codable {
    let small, normal, large: String?
    let png: String?
    let artCrop, borderCrop: String?

    enum CodingKeys: String, CodingKey {
        case small, normal, large, png
        case artCrop
        case borderCrop
    }
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

enum Layout: String, Codable {
    case adventure = "adventure"
    case leveler = "leveler"
    case host = "host"
    case modalDfc = "modal_dfc"
    case normal = "normal"
    case transform = "transform"
    case comboPiece = "combo_piece"
    case token = "token"
    case doubleFacedToken = "double_faced_token"
}

// MARK: - Legalities
struct Legalities: Codable {
    let standard, future, historic, gladiator: Alchemy?
    let pioneer, explorer, modern, legacy: Alchemy?
    let pauper, vintage, penny, commander: Alchemy?
    let brawl, historicbrawl, alchemy: Alchemy?
    let paupercommander: Paupercommander?
    let duel, oldschool, premodern: Alchemy?
}

enum Alchemy: String, Codable {
    case banned = "banned"
    case legal = "legal"
    case notLegal = "not_legal"
}

enum Paupercommander: String, Codable {
    case legal = "legal"
    case notLegal = "not_legal"
    case restricted = "restricted"
}

enum DatumObject: String, Codable {
    case card = "card"
}

// MARK: - Preview
struct Preview: Codable {
    let source: String?
    let sourceURI: String?
    let previewedAt: String?

    enum CodingKeys: String, CodingKey {
        case source
        case sourceURI
        case previewedAt
    }
}

// MARK: - PurchaseUris
struct PurchaseUris: Codable {
    let tcgplayer, cardmarket, cardhoarder: String?
}

enum Rarity: String, Codable {
    case common = "common"
    case mythic = "mythic"
    case rare = "rare"
    case uncommon = "uncommon"
}

// MARK: - RelatedUris
struct RelatedUris: Codable {
    let tcgplayerInfiniteArticles, tcgplayerInfiniteDecks, edhrec: String?
    let gatherer: String?

    enum CodingKeys: String, CodingKey {
        case tcgplayerInfiniteArticles
        case tcgplayerInfiniteDecks
        case edhrec, gatherer
    }
}

enum SecurityStamp: String, Codable {
    case arena = "arena"
    case oval = "oval"
    case triangle = "triangle"
}

enum SetType: String, Codable {
    case alchemy = "alchemy"
    case box = "box"
    case commander = "commander"
    case core = "core"
    case draftInnovation = "draft_innovation"
    case duelDeck = "duel_deck"
    case expansion = "expansion"
    case funny = "funny"
    case masters = "masters"
    case starter = "starter"
}
