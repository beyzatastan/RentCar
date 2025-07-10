//
//  SurucuBilViewController.swift
//  RentCar
//
//  Created by beyza nur on 27.12.2024.
//

import UIKit

class SurucuBilgiViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var surucuView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    let surucukimliktx = UITextField()
    let surucukimliklb = UILabel()
    
    let ehliyettx=UITextField()
    let ehliteylb=UILabel()
    
    var customerBilgi3:AddCustomerModel?
    var viewModel = CustomerViewModel()
    
    @IBOutlet weak var main2View: UIView!
    
    //veritabanı için
    var carId:Int?
    
    var startLocationId:Int?
    var endLocationId:Int?
    
    var startDate:Date?
    var endDate:Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        surucuView.layer.cornerRadius = 10
        
        addToolBarToTextField(ehliyettx)
        
        surucukimliktx.placeholder = "Ehliyet Numarası"
        surucukimliktx.borderStyle = .roundedRect
        surucukimliktx.delegate = self
        surucukimliktx.keyboardType = .phonePad
        surucukimliktx.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(surucukimliktx)
        
        
        surucukimliklb.text = "Ehliyet Numarası"
        surucukimliklb.font = UIFont.systemFont(ofSize: 14)
        surucukimliklb.textColor = .gray
        surucukimliklb.isHidden = true
        surucukimliklb.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(surucukimliklb)
        
        ehliyettx.placeholder = "Ehliyet Veriliş Tarihi"
        ehliyettx.borderStyle = .roundedRect
        ehliyettx.delegate = self
        ehliyettx.keyboardType = .phonePad
        ehliyettx.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(ehliyettx)
        
        
        ehliteylb.text = "Ehliyet Veriliş Tarihi"
        ehliteylb.font = UIFont.systemFont(ofSize: 14)
        ehliteylb.textColor = .gray
        ehliteylb.isHidden = true
        ehliteylb.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(ehliteylb)
        
        NSLayoutConstraint.activate([
            surucukimliklb.leadingAnchor.constraint(equalTo: surucukimliktx.leadingAnchor),
            surucukimliklb.bottomAnchor.constraint(equalTo: surucukimliktx.topAnchor),
            
            surucukimliktx.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            surucukimliktx.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            surucukimliktx.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ehliteylb.leadingAnchor.constraint(equalTo: ehliyettx.leadingAnchor),
            ehliteylb.bottomAnchor.constraint(equalTo: ehliyettx.topAnchor),
            
            ehliyettx.topAnchor.constraint(equalTo: surucukimliktx.bottomAnchor, constant: 15),
            ehliyettx.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ehliyettx.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           
        ])
        navigationItem.backButtonTitle = ""
         
        // Özel UIButton oluştur
          let backButton = UIButton(type: .system)
          backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
          backButton.tintColor = .white
          backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
          backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
          
          // Dikey konum için transform uygula
          backButton.transform = CGAffineTransform(translationX: 0, y: -5) // `y: -5` butonu yukarı taşır
          
          // UIBarButtonItem olarak ekle
          let barButtonItem = UIBarButtonItem(customView: backButton)
          navigationItem.leftBarButtonItem = barButtonItem
      }

      @objc func backButtonTapped() {
          navigationController?.popViewController(animated: true)
      }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == surucukimliktx {
            surucukimliklb.isHidden = false
        } else if textField == ehliyettx {
            ehliteylb.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == surucukimliktx && textField.text?.isEmpty == true {
            surucukimliklb.isHidden = true
        } else if textField == ehliyettx && textField.text?.isEmpty == true {
            ehliteylb.isHidden = true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == ehliyettx {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let updatedString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            if updatedString.length > maxLength {
                return false
            }
            
            let formattedString = formatDate(updatedString as String)
            textField.text = formattedString
            return false
        }
        return true
    }
    func formatDate(_ date: String) -> String {
        let digits = date.filter { "0"..."9" ~= $0 }
        var formattedDate = ""
        
        if digits.count > 0 {
            formattedDate = digits.prefix(2) + "-"
        }
        
        if digits.count > 2 {
            formattedDate += digits.dropFirst(2).prefix(2) + "-"
        }
        
        if digits.count > 4 {
            formattedDate += digits.dropFirst(4).prefix(4)
        }
        
        return formattedDate
    }
    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit() // Toolbar'ı uygun boyutlara ayarlayalım.

        // Done butonunu oluşturuyoruz.
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [doneButton] // Sadece "Done" butonunu toolbar'a ekliyoruz.

        return toolBar
    }
    func addToolBarToTextField(_ textField: UITextField) {
        textField.inputAccessoryView = createToolBar()
    }
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    @IBAction func devamButtonClicked(_ sender: Any) {
        guard let drivingLicenseNumber = surucukimliktx.text, !drivingLicenseNumber.isEmpty else {
            showAlert(message: "Ehliyet numarası boş olamaz.")
            return
        }
        guard let drivingLicenseDateText = ehliyettx.text, !drivingLicenseDateText.isEmpty else {
            showAlert(message: "Ehliyet veriliş tarihi boş olamaz.")
            return
        }
        
        customerBilgi3?.drivingLicenseNumber = drivingLicenseNumber
        if let drivingLicenseDate = convertToISO8601Date(drivingLicenseDateText) {
            customerBilgi3?.drivingLicenseIssuedDate = drivingLicenseDate
        } else {
            showAlert(message: "Geçersiz ehliyet veriliş tarihi formatı. Lütfen DD-MM-YYYY formatında girin.")
            return
        }
        
        guard let customer = customerBilgi3 else {
            showAlert(message: "Müşteri bilgileri eksik.")
            return
        }
        
        // Zorunlu alanları kontrol et
        guard !customer.firstName.isEmpty else {
            showAlert(message: "Ad alanı boş olamaz.")
            return
        }
        guard !customer.identityNumber.isEmpty else {
            showAlert(message: "TCKN veya pasaport numarası boş olamaz.")
            return
        }
        guard customer.userId > 0 else {
            showAlert(message: "Geçersiz kullanıcı ID'si.")
            return
        }
        
        print("Gönderilen müşteri verileri: \(customer)")
        
        viewModel.addCustomer(customer: customer) { customerId in
            DispatchQueue.main.async {
                if let customerId = customerId {
                    UserDefaults.standard.set(customerId, forKey: "customerId")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "odeme") as? OdemeViewController
                    guard let vc = vc else {
                        self.showAlert(message: "Ödeme ekranı yüklenemedi.")
                        return
                    }
                    vc.customerId = customerId
                    vc.carId = self.carId
                    vc.startLocationId = self.startLocationId
                    vc.endLocationId = self.endLocationId
                    vc.endDate = self.endDate
                    vc.startDate = self.startDate
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let errorMessage = self.viewModel.errorMessage ?? "Bilinmeyen bir hata oluştu."
                    self.showAlert(message: "Müşteri kaydedilemedi: \(errorMessage)")
                }
            }
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    func convertToISO8601Date(_ dateString: String?) -> String? {
        guard let dateString = dateString else {
            return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let date = dateFormatter.date(from: dateString) {
            let isoFormatter = ISO8601DateFormatter()
            return isoFormatter.string(from: date)
        } else {
            return nil }
    }
}
