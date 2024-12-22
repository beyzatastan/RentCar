//
//  UserModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation
struct UserModel: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var passwordHash: String
    var phoneNumber: String
    var role: String // Kullanıcı rolü, örn: "Customer", "Admin"
}
