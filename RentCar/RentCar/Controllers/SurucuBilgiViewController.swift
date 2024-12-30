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
        if let currentField = ehliyettx  as? UITextField {
            currentField.resignFirstResponder()
        }
    }
    @IBAction func devamButtonClicked(_ sender: Any) {
        customerBilgi3?.drivingLicenseIssuedDate = ehliyettx.text ?? ""
        customerBilgi3?.drivingLicenseNumber = surucukimliktx.text ?? ""
        
        if let drivingLicenseDate = convertToISO8601Date(ehliyettx.text) {
            customerBilgi3?.drivingLicenseIssuedDate = drivingLicenseDate } else {
                print("Invalid date format for drivingLicenseIssuedDate")
                return
            }
        
        viewModel.addCustomer(customer: customerBilgi3!) { customerId in
            print("UserDefaults Calıştı")
            print(UserDefaults.standard.string(forKey: "customerId"))
            // customerId verisi alındığında
            if let customerId = customerId {
                let vc = self.storyboard?.instantiateViewController(identifier: "odeme") as! OdemeViewController
                vc.customerId = customerId
                
                vc.carId = self.carId
                vc.startLocationId = self.startLocationId
                vc.endLocationId = self.endLocationId
                vc.endDate = self.endDate
                vc.startDate = self.startDate
                
                // Son olarak geçişi sağlıyoruz
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Hata durumunda gerekli işlemler yapılabilir
                print("Customer ID could not be fetched.")
            }
        }
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
