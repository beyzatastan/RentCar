//
//  FaturaViewController.swift
//  RentCar
//
//  Created by beyza nur on 21.11.2024.
//
import UIKit

class FaturaViewController: UIViewController, UITextFieldDelegate{
    
    private weak static var _currentFirstResponder: UIResponder?
    
    @IBOutlet weak var surucuView: UIView!
    @IBOutlet weak var izinView: UIView!
    let nameField = UITextField()
    let nameLabel = UILabel()
    
    let soyadText = UITextField()
    let soyadLabel = UILabel()
    
    let epostaText = UITextField()
    let epostaLabel = UILabel()
    
    let telefonText = UITextField()
    let telefonLabel = UILabel()
    
    let dogumText = UITextField()
    let dogumLabel = UILabel()
    
    let tcText = UITextField()
    let tcLabel = UILabel()
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    var buton1doluMu = true
    var buton3=false
    var buton4 = false
    @IBOutlet weak var line: UILabel!
    
    
    //veritabanı için
    var carId:Int?
    var userId:Int?
    
    var startLocationId:Int?
    var endLocationId:Int?
    
    var startDate:Date?
    var endDate:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surucuView.layer.cornerRadius = 10
        izinView.layer.cornerRadius = 10

        addToolBarToTextField(tcText)
        // Ad
        nameLabel.text = "Ad"
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = .gray
        nameLabel.isHidden = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameField.placeholder = "Ad"
        nameField.borderStyle = .roundedRect
        nameField.delegate = self
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        // Soyad
        soyadLabel.text = "Soyad"
        soyadLabel.font = UIFont.systemFont(ofSize: 12)
        soyadLabel.textColor = .gray
        soyadLabel.isHidden = true
        soyadLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soyadLabel)
        
        soyadText.placeholder = "Soyad"
        soyadText.borderStyle = .roundedRect
        soyadText.delegate = self
        soyadText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soyadText)
        
        // E-Posta
        epostaLabel.text = "E-Posta"
        epostaLabel.font = UIFont.systemFont(ofSize: 12)
        epostaLabel.textColor = .gray
        epostaLabel.isHidden = true
        epostaLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(epostaLabel)
        
        epostaText.placeholder = "E-Posta"
        epostaText.borderStyle = .roundedRect
        epostaText.delegate = self
        epostaText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(epostaText)
        
        // Telefon
        telefonLabel.text = "Telefon Numarası"
        telefonLabel.font = UIFont.systemFont(ofSize: 12)
        telefonLabel.textColor = .gray
        telefonLabel.isHidden = true
        telefonLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(telefonLabel)
        
        telefonText.placeholder = "Telefon Numarası"
        telefonText.borderStyle = .roundedRect
        telefonText.delegate = self
        telefonText.keyboardType = .phonePad
        telefonText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(telefonText)
        
        // Doğum Tarihi
        dogumLabel.text = "Doğum Tarihi"
        dogumLabel.font = UIFont.systemFont(ofSize: 12)
        dogumLabel.textColor = .gray
        dogumLabel.isHidden = true
        dogumLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dogumLabel)
        
        dogumText.placeholder = "Doğum Tarihi (DD-MM-YYYY)"
        dogumText.borderStyle = .roundedRect
        dogumText.keyboardType = .phonePad
        dogumText.delegate = self
        dogumText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dogumText)
        
        
        
        //TC KİMLİK
        tcLabel.text = "TCKN"
        tcLabel.font = UIFont.systemFont(ofSize: 12)
        tcLabel.textColor = .gray
        tcLabel.isHidden = true
        tcLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tcLabel)
        
        tcText.placeholder = "TCKN"
        tcText.borderStyle = .roundedRect
        tcText.keyboardType = .phonePad
        tcText.delegate = self
        tcText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tcText)
        
        // Constraints
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameField.topAnchor),
            
            nameField.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            soyadLabel.leadingAnchor.constraint(equalTo: soyadText.leadingAnchor),
            soyadLabel.bottomAnchor.constraint(equalTo: soyadText.topAnchor),
            
            soyadText.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            soyadText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            soyadText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            epostaLabel.leadingAnchor.constraint(equalTo: epostaText.leadingAnchor),
            epostaLabel.bottomAnchor.constraint(equalTo: epostaText.topAnchor),
            
            epostaText.topAnchor.constraint(equalTo: soyadText.bottomAnchor, constant: 15),
            epostaText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            epostaText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            telefonLabel.leadingAnchor.constraint(equalTo: telefonText.leadingAnchor),
            telefonLabel.bottomAnchor.constraint(equalTo: telefonText.topAnchor),
            
            telefonText.topAnchor.constraint(equalTo: epostaText.bottomAnchor, constant: 15),
            telefonText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            telefonText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dogumLabel.leadingAnchor.constraint(equalTo: dogumText.leadingAnchor),
            dogumLabel.bottomAnchor.constraint(equalTo: dogumText.topAnchor),
            
            dogumText.topAnchor.constraint(equalTo: telefonText.bottomAnchor, constant: 15),
            dogumText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dogumText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tcLabel.leadingAnchor.constraint(equalTo: tcText.leadingAnchor),
            tcLabel.bottomAnchor.constraint(equalTo: tcText.topAnchor),
            
            tcText.topAnchor.constraint(equalTo: dogumText.bottomAnchor, constant: 50),
            tcText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tcText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        if textField == nameField {
            nameLabel.isHidden = false
        } else if textField == soyadText {
            soyadLabel.isHidden = false
        } else if textField == epostaText {
            epostaLabel.isHidden = false
        } else if textField == telefonText {
            telefonLabel.isHidden = false
        } else if textField == dogumText {
            dogumLabel.isHidden = false
        }
        else if textField == tcText {
            tcLabel.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameField && textField.text?.isEmpty == true {
            nameLabel.isHidden = true
        } else if textField == soyadText && textField.text?.isEmpty == true {
            soyadLabel.isHidden = true
        } else if textField == epostaText && textField.text?.isEmpty == true {
            epostaLabel.isHidden = true
        } else if textField == telefonText && textField.text?.isEmpty == true {
            telefonLabel.isHidden = true
        } else if textField == dogumText && textField.text?.isEmpty == true {
            dogumLabel.isHidden = true
        }else if textField == tcText && textField.text?.isEmpty == true {
            tcLabel.isHidden = true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == telefonText {
            let maxLength = 17 // format: +90 543-786-6776
            let currentString: NSString = textField.text! as NSString
            let updatedString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            if updatedString.length > maxLength {
                return false
            }
            
            let formattedString = formatPhoneNumber(updatedString as String)
            textField.text = formattedString
            return false
        }
        
        // Doğum tarihi formatı
        if textField == dogumText {
            let maxLength = 10 // format: 12-23-2003
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
    
    func formatPhoneNumber(_ number: String) -> String {
        // Sadece rakamları almak için
        let cleanedNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        var formattedNumber = "+90 "
        
        if cleanedNumber.count > 0 {
            formattedNumber = String(cleanedNumber.prefix(3))
        }
        
        if cleanedNumber.count > 3 {
            formattedNumber += "-" + String(cleanedNumber.dropFirst(3).prefix(3))
        }
        
        if cleanedNumber.count > 6 {
            formattedNumber += "-" + String(cleanedNumber.dropFirst(6).prefix(4))
        }
        
        return formattedNumber
    }
    
    // Doğum tarihini formatla
    func formatDate(_ date: String) -> String {
        var digits = date.filter { "0"..."9" ~= $0 }
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
        // Hangi textField aktifse onu "resign" et (yani klavyeyi kapat).
        if let currentField = tcText as? UITextField {
            currentField.resignFirstResponder()
        }
    }
    
    @IBAction func button1Tapped(_ sender: Any) {
        tcLabel.text = "TCKN"
        tcText.placeholder="TCKN"
        button1.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button2.setImage(UIImage(systemName: "circle"), for: .normal)
        buton1doluMu = true
    }
    @IBAction func button2Tapped(_ sender: Any) {
        tcLabel.text = "PASAPORT NO"
        tcText.placeholder="PASAPORT NO"
        button1.setImage(UIImage(systemName: "circle"), for: .normal)
        button2.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        buton1doluMu = false
    }
    @IBAction func button3Tapped(_ sender: Any) {
        if(buton3==false){
            buton3=true
            button3.setImage(UIImage(systemName: "square.fill"), for: .normal)
        }else if (buton3==true){
            button3.setImage(UIImage(systemName: "square"), for: .normal)
            buton3=false
        }
    }
    @IBAction func button4Tapped(_ sender: Any) {
        if(buton4==false){
            buton4=true
            button4.setImage(UIImage(systemName: "square.fill"), for: .normal)
        }else if (buton4==true){
            button4.setImage(UIImage(systemName: "square"), for: .normal)
            buton4=false
        }
    }
    
    @IBAction func devamButtonClicked(_ sender: Any) {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userIdInt = Int(userIdString) {
            self.userId = userIdInt
            print("Customer ID: \(userIdInt)")
            var userInput = AddCustomerModel(userId: userId!,
                                             firstName: nameField.text ?? "",
                                             lastName: soyadText.text ?? "",
                                             email: epostaText.text ?? "",
                                             phoneNumber: telefonText.text ?? "",
                                             identityNumber: tcText.text ?? "",
                                             drivingLicenseIssuedDate: "",
                                             drivingLicenseNumber: "",
                                             birthDate: dogumText.text ?? "",
                                             city: "",
                                             district: "",
                                             address: "",
                                             postalCode: "",
                                             role: "customer")
            
            if let dogumText = convertToISO8601Date(dogumText.text) {
                userInput.birthDate = dogumText } else {
                    print("Invalid date format for dogumText")
                    return
                }
            
            
            let vc=storyboard?.instantiateViewController(identifier: "nextFatura") as! NextFaturaViewController
            vc.customerBilgi2=userInput
            vc.carId=self.carId
            vc.startLocationId=self.startLocationId
            vc.endLocationId=self.endLocationId
            vc.endDate=self.endDate
            vc.startDate=self.startDate
            navigationController?.pushViewController(vc, animated: true)
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
   

