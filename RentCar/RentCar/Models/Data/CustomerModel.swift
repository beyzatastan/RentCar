import Foundation

// CustomerModel structure, corresponding to the C# model
struct CustomerModel: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var identityNumber: String
    var drivingLicenseIssuedDate: String // ISO 8601 format
    var drivingLicenseNumber: String
    var birthDate: String // ISO 8601 format
    var city: String
    var district: String
    var address: String
    var postalCode: String
    var role: String? // Role can be null
    var reviews: ReviewModel?
    var bookings: BookingModel?
}
struct AddCustomerModel: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var identityNumber: String
    var drivingLicenseIssuedDate: String // ISO 8601 format
    var drivingLicenseNumber: String
    var birthDate: String // ISO 8601 format
    var city: String
    var district: String
    var address: String
    var postalCode: String
    var role: String?
}

struct CustomerResponse: Codable {
    let message: String
    let customerId: Int
}
