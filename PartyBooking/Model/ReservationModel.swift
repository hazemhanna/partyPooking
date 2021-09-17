import Foundation

// MARK: - ReservationModelJSON
struct ReservationModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: ReservationModels?
}

// MARK: - Result
struct ReservationModels : Codable {
    let currentBookings, completedBookings, cancelledBookings: ReservationModel?
}

// MARK: - Bookings
struct ReservationModel: Codable {
    let data: [Reservation]?
    let total, count, perPage, currentPage: Int?
    let totalPages: Int?
    let prev: String?
    let next: String?

    enum CodingKeys: String, CodingKey {
        case data, total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case prev, next
    }
}

// MARK: - Datum
struct Reservation: Codable {
    let id, userID, artistID: Int?
    let status: String?
    let date: String?
    let fromTime, toTime: String?
    let price, taxes, rate: Int?
    let address: String?
    let isRated: Int?
    let cancelReason: String?
    let artist: Artist?
    let partyType, area: Area?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case artistID = "artist_id"
        case status, date
        case fromTime = "from_time"
        case toTime = "to_time"
        case price, taxes, rate, address
        case isRated = "is_rated"
        case cancelReason = "cancel_reason"
        case artist
        case partyType = "party_type"
        case area
    }
}

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let arName, enName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
    }
}

// MARK: - Artist
struct Artist: Codable {
    let firstName: String?
    let lastName: String?
    let favourite: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case favourite
    }
}

