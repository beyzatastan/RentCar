struct UserModel: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var emailAddress: String
    var phoneNumber: String
    var password: String
    var customers: [CustomerModel]? // Change to array if a user can have multiple customers
}

struct AddUserModel: Codable {
    var firstName: String
    var lastName: String
    var emailAddress: String
    var phoneNumber: String
    var password: String
}

struct UserResponse: Codable {
    let message: String
    let userId: Int
}
struct LoginResponse: Decodable {
    let message: String
    let userId: Int
}
