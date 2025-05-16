//
//  UserViewModel.swift
//  RentCar
//
//  Created by beyza nur on 30.12.2024.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var userWebService = UserWebServices()
    private var cancellables = Set<AnyCancellable>()

    func addUser(user: AddUserModel, completion: @escaping (Int?) -> Void) {
        isLoading = true
        userWebService.addUser(user: user) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    UserDefaults.standard.set(response.userId, forKey: "userId")
                    completion(response.userId) // fetchUserDetails kaldırıldı
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("addUser failed with error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
    func fetchUserDetails(userId: Int, completion: @escaping (Int?) -> Void) {
        userWebService.fetchUserById(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                completion(userId)
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                print("fetchUserById failed with error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

}
