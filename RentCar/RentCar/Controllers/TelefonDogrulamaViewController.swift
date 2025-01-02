//
//  TelefonDogrulamaViewController.swift
//  RentCar
//
//  Created by beyza nur on 26.11.2024.
//

import UIKit

class TelefonDogrulamaViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var againLabel: UILabel!
    @IBOutlet weak var sayacText: UILabel!
    var otpFields: [UITextField] = []
    
    var customerBilgi : AddCustomerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        bottomView.layer.cornerRadius = 10
        
        createOtpFields()
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

    func createOtpFields() {
        let numberOfFields = 6 // 6 haneli kod
        let fieldWidth: CGFloat = 40
        let spacing: CGFloat = 10
        let totalWidth = CGFloat(numberOfFields) * fieldWidth + CGFloat(numberOfFields - 1) * spacing
        
        let startX = (view.frame.width - totalWidth) / 2
        let startY = view.frame.height / 2
        
        for i in 0..<numberOfFields {
            let textField = UITextField()
            textField.frame = CGRect(x: startX + CGFloat(i) * (fieldWidth + spacing), y: startY, width: fieldWidth, height: 50)
            textField.borderStyle = .none
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.cornerRadius = 5
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 20)
            textField.keyboardType = .numberPad
            textField.delegate = self
            textField.tag = i
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            otpFields.append(textField)
            view.addSubview(textField)
        }
        
        otpFields.first?.becomeFirstResponder() // İlk alanı otomatik odakla
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let currentIndex = textField.tag
        
        // Eğer bir rakam girildiyse bir sonraki textField'a geç
        if let text = textField.text, text.count == 1 {
            if currentIndex < otpFields.count - 1 {
                otpFields[currentIndex + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder() // Son alan
            }
        } else if textField.text?.isEmpty == true {
            // Geri silme yapılırsa önceki alana geç
            if currentIndex > 0 {
                otpFields[currentIndex - 1].becomeFirstResponder()
            }
        }
    }
    
    func getOtpCode() -> String {
        return otpFields.compactMap { $0.text }.joined()
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
        if let currentField = otpFields as? UITextField {
            currentField.resignFirstResponder()
        }
    }
    @IBAction func devamButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "nextFatura") as! NextFaturaViewController
        vc.customerBilgi2 = customerBilgi
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}




