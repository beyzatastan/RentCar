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
        userWebService.addUser(user:user) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    // Müşteri ID'sini aldıktan sonra müşteri detaylarını alıyoruz
                    //müşteriyi kaydet
                    UserDefaults.standard.set(response.userId, forKey: "userId")
                    self?.fetchUserDetails(userId: response.userId, completion: completion)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(nil)
                }
            }
        }
    }

    func fetchUserDetails(userId: Int, completion: @escaping (Int?) -> Void) {
        // Müşteri detaylarını almak için başka bir API çağrısı yapıyoruz
        userWebService.fetchUserById(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                    print(user.id)
                    completion(user.id)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(nil)
                }
            }
        }
    
    }

}
