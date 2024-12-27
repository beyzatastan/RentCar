import Foundation
import Combine

class CustomerViewModel: ObservableObject {
    @Published var customer: CustomerModel?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var customerWebService = CustomerWebService()
    private var cancellables = Set<AnyCancellable>()

    func addCustomer(customer: AddCustomerModel) {
        isLoading = true
        customerWebService.addCustomer(customer: customer) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let customer):
                    self?.customer = customer
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
