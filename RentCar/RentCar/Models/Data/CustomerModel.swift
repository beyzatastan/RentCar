import Foundation

// CustomerModel structure, corresponding to the C# model
struct CustomerModel: Codable {
    var id: Int
    var userId: Int // userId should be Int to match the type in UserModel
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
    var reviews: ReviewModel? // Ensure ReviewModel is defined
    var bookings: BookingModel? // Ensure BookingModel is defined
}

struct AddCustomerModel: Codable {
    var userId: Int // userId should be Int, assuming it's an integer in the backend
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
