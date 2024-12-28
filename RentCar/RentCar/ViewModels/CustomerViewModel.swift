import Foundation
import Combine

class CustomerViewModel: ObservableObject {
    @Published var customer: CustomerModel?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var customerWebService = CustomerWebService()
    private var cancellables = Set<AnyCancellable>()

    func addCustomer(customer: AddCustomerModel, completion: @escaping (Int?) -> Void) {
        isLoading = true
        customerWebService.addCustomer(customer: customer) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    // Müşteri ID'sini aldıktan sonra müşteri detaylarını alıyoruz
                    self?.fetchCustomerDetails(customerId: response.customerId, completion: completion)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(nil)
                }
            }
        }
    }

    func fetchCustomerDetails(customerId: Int, completion: @escaping (Int?) -> Void) {
        // Müşteri detaylarını almak için başka bir API çağrısı yapıyoruz
        customerWebService.fetchCustomerById(customerId: customerId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let customer):
                    self?.customer = customer
                    print(customer.id)
                    completion(customer.id)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(nil)
                }
            }
        }
    }
}
