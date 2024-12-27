//
//  OdemeViewController.swift
//  RentCar
//
//  Created by beyza nur on 26.11.2024.
//

import UIKit

class OdemeViewController: UIViewController ,UITextFieldDelegate{

    var customerId: Int?
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var securityButton: UIButton!

    var butonDolu = false
    
    let kartNumText = UITextField()
    let kartNumLabel = UILabel()
    
    let kartAdıText=UITextField()
    let kartAdıLabel=UILabel()
    
    let sonKullanmaText=UITextField()
    let sonKullanmalabel=UILabel()
    
    let cvvText=UITextField()
    let cvvLabel=UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        upView.layer.cornerRadius = 10
        
        addToolBarToTextField(cvvText)
        
        kartNumText.placeholder = "Kart Numarası"
        kartNumText.borderStyle = .roundedRect
        kartNumText.delegate = self
        kartNumText.keyboardType = .phonePad
        kartNumText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(kartNumText)
        
        
        kartNumLabel.text = "Kart Numarası"
        kartNumLabel.font = UIFont.systemFont(ofSize: 14)
        kartNumLabel.textColor = .gray
        kartNumLabel.isHidden = true
        kartNumLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(kartNumLabel)
        
        
        kartAdıText.placeholder = "Kart Üzerindeki İsim"
        kartAdıText.borderStyle = .roundedRect
        kartAdıText.delegate = self
        kartAdıText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(kartAdıText)
        
        
        kartAdıLabel.text = "Kart Üzerindeki İsim"
        kartAdıLabel.font = UIFont.systemFont(ofSize: 14)
        kartAdıLabel.textColor = .gray
        kartAdıLabel.isHidden = true
        kartAdıLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(kartAdıLabel)
        
        sonKullanmaText.placeholder = "Son Kullanma Tarihi"
        sonKullanmaText.borderStyle = .roundedRect
        sonKullanmaText.keyboardType = .phonePad
        sonKullanmaText.delegate = self
        sonKullanmaText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(sonKullanmaText)
        
        
        sonKullanmalabel.text = "Son Kullanma Tarihi"
        sonKullanmalabel.font = UIFont.systemFont(ofSize: 14)
        sonKullanmalabel.textColor = .gray
        sonKullanmalabel.isHidden = true
        sonKullanmalabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(sonKullanmalabel)
        
        
        cvvText.placeholder = "CVV/CVC"
        cvvText.borderStyle = .roundedRect
        cvvText.delegate = self
        cvvText.keyboardType = .phonePad
        cvvText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(cvvText)
        
        
        cvvLabel.text = "CVV/CVC"
        cvvLabel.font = UIFont.systemFont(ofSize: 14)
        cvvLabel.textColor = .gray
        cvvLabel.isHidden = true
        cvvLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(cvvLabel)
      
            NSLayoutConstraint.activate([
                kartNumLabel.leadingAnchor.constraint(equalTo: kartNumText.leadingAnchor),
                kartNumLabel.bottomAnchor.constraint(equalTo: kartNumText.topAnchor),
                
                kartNumText.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
                kartNumText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                kartNumText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                
                kartAdıLabel.leadingAnchor.constraint(equalTo: kartAdıText.leadingAnchor),
                kartAdıLabel.bottomAnchor.constraint(equalTo: kartAdıText.topAnchor),
                
                kartAdıText.topAnchor.constraint(equalTo: kartNumText.bottomAnchor, constant: 15),
                kartAdıText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                kartAdıText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                
                sonKullanmalabel.leadingAnchor.constraint(equalTo: sonKullanmaText.leadingAnchor),
                sonKullanmalabel.bottomAnchor.constraint(equalTo: sonKullanmaText.topAnchor),
                
                sonKullanmaText.topAnchor.constraint(equalTo: kartAdıText.bottomAnchor, constant: 15),
                sonKullanmaText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                sonKullanmaText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                
                cvvLabel.leadingAnchor.constraint(equalTo: cvvText.leadingAnchor),
                cvvLabel.bottomAnchor.constraint(equalTo: cvvText.topAnchor),
                
                cvvText.topAnchor.constraint(equalTo: sonKullanmaText.bottomAnchor, constant: 15),
                cvvText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                cvvText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
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
        if textField == kartNumText {
            kartNumLabel.isHidden = false
        } else if textField == kartAdıText {
            kartAdıLabel.isHidden = false
        } else if textField == sonKullanmaText {
            sonKullanmalabel.isHidden = false
        } else if textField == cvvText {
            cvvLabel.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == kartNumText && textField.text?.isEmpty == true {
            kartNumLabel.isHidden = true
        } else if textField == kartAdıText && textField.text?.isEmpty == true {
            kartAdıLabel.isHidden = true
        } else if textField == sonKullanmaText && textField.text?.isEmpty == true {
            sonKullanmalabel.isHidden = true
        } else if textField == cvvText && textField.text?.isEmpty == true {
            cvvLabel.isHidden = true
        }
    }
    //son kullanma date
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == sonKullanmaText {
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
        if textField == cvvText {
            let maxLength = 3
            let currentSt: NSString = textField.text! as NSString
            let updatedString: NSString = currentSt.replacingCharacters(in: range, with: string) as NSString
            
            if updatedString.length > maxLength {
                return false
            }
            
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
        // Hangi textField aktifse onu "resign" et (yani klavyeyi kapat).
        if let currentField = cvvText as? UITextField {
            currentField.resignFirstResponder()
        }
    }
    
   
    @IBAction func devamButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "onay") as! OnayPageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func securityButtonClicked(_ sender: Any) {
        if (butonDolu == false) {
            securityButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            butonDolu = true
        } else if(butonDolu == true){
            securityButton.setImage(UIImage(systemName: "square"), for: .normal)
            butonDolu = false
        }
        
    }
}

class SurucuBilgiViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    let surucukimliktx = UITextField()
    let surucukimliklb = UILabel()
    
    let ehliyettx=UITextField()
    let ehliteylb=UILabel()
    
    var customerBilgi3:AddCustomerModel?
    var viewModel = CustomerViewModel()
    
    @IBOutlet weak var main2View: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        main2View.layer.cornerRadius = 10
        
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
        
        viewModel.addCustomer(customer: customerBilgi3!)
        
        
        let vc = storyboard?.instantiateViewController(identifier: "odeme") as! OdemeViewController
        
            navigationController?.pushViewController(vc, animated: true)
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
