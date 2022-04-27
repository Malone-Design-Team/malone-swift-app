

import Foundation

// MARK: - AnnouncementsObject
struct AnnouncementsObject: Codable {
    let posts: [Post]
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case posts
        case meta
    }
}

// MARK: - Meta
struct Meta: Codable {
    let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case pagination
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let page: Int
    let limit: Int
    let pages: Int
    let total: Int
    let next: JSONNull?
    let prev: JSONNull?

    enum CodingKeys: String, CodingKey {
        case page
        case limit
        case pages
        case total
        case next
        case prev
    }
}

// MARK: - Post
struct Post: Codable {
    let id: String
    let title: String
    let published_at: String
    let custom_excerpt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case published_at
        case custom_excerpt
        case url
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
