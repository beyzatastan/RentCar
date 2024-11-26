//
//  NextFaturaViewController.swift
//  RentCar
//
//  Created by beyza nur on 23.11.2024.
//

import UIKit

class NextFaturaViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var buton1: UIButton!
    @IBOutlet weak var buton2: UIButton!
    var buton1Dolu=true
    
    let firmaAdıText = UITextField()
    let firmaAdıLabel = UILabel()
    
    let vergiDText = UITextField()
    let vergiDLabel = UILabel()
    
    let vergiNumText = UITextField()
    let vergiNumLabel = UILabel()
    
    let ilField = UITextField()
    let ilLabel = UILabel()
    
    let ilceText = UITextField()
    let ilceLabel = UILabel()
    
    let adresText = UITextField()
    let adresLabel = UILabel()
    
    let postaKoduText = UITextField()
    let postaKoduLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addToolBarToTextField(ilField)
        addToolBarToTextField(ilceText)
        addToolBarToTextField(adresText)
        addToolBarToTextField(postaKoduText)
        
        addToolBarToTextField(firmaAdıText)
        addToolBarToTextField(vergiNumText)
        addToolBarToTextField(vergiDText)
        
        mainView.layer.cornerRadius = 10
        firmaAdıLabel.isHidden = true
        firmaAdıText.isHidden = true
        vergiDText.isHidden = true
        vergiDLabel.isHidden = true
        vergiNumText.isHidden = true
        vergiNumLabel.isHidden = true
        firmaAdıText.delegate = self

        
        firmaAdıLabel.text = "FİRMA ADI"
        firmaAdıLabel.font = UIFont.systemFont(ofSize: 12)
        firmaAdıLabel.textColor = .gray
        firmaAdıLabel.isHidden = true
        firmaAdıLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(firmaAdıLabel)
        
        firmaAdıText.placeholder = "FİRMA ADI"
        firmaAdıText.borderStyle = .roundedRect
        firmaAdıText.delegate = self
        firmaAdıText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(firmaAdıText)
        
        vergiDLabel.text = "VERGİ DAİRESİ"
        vergiDLabel.font = UIFont.systemFont(ofSize: 12)
        vergiDLabel.textColor = .gray
        vergiDLabel.isHidden = true
        vergiDLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(vergiDLabel)
        
        vergiDText.placeholder = "VERDİ DAİRESİ"
        vergiDText.borderStyle = .roundedRect
        vergiDText.delegate = self
        vergiDText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(vergiDText)
        
        vergiNumLabel.text = "VERGİ NUMARASI"
        vergiNumLabel.font = UIFont.systemFont(ofSize: 12)
        vergiNumLabel.textColor = .gray
        vergiNumLabel.isHidden = true
        vergiNumLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(vergiNumLabel)
        
        vergiNumText.placeholder = "VERGİ NUMARASI"
        vergiNumText.borderStyle = .roundedRect
        vergiNumText.delegate = self
        vergiNumText.keyboardType = .numberPad
        vergiNumText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(vergiNumText)
        
        ilLabel.text = "İL"
        ilLabel.font = UIFont.systemFont(ofSize: 12)
        ilLabel.textColor = .gray
        ilLabel.isHidden = true
        ilLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(ilLabel)
        
        ilField.placeholder = "İL"
        ilField.borderStyle = .roundedRect
        ilField.delegate = self
        ilField.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(ilField)
        
        ilceLabel.text = "İLÇE"
        ilceLabel.font = UIFont.systemFont(ofSize: 12)
        ilceLabel.textColor = .gray
        ilceLabel.isHidden = true
        ilceLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(ilceLabel)
        
        ilceText.placeholder = "İLÇE"
        ilceText.borderStyle = .roundedRect
        ilceText.delegate = self
        ilceText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(ilceText)
        
        adresLabel.text = "ADRES"
        adresLabel.font = UIFont.systemFont(ofSize: 12)
        adresLabel.textColor = .gray
        adresLabel.isHidden = true
        adresLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(adresLabel)
        
        adresText.placeholder = "ADRES"
        adresText.borderStyle = .roundedRect
        adresText.delegate = self
        adresText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(adresText)
        
        postaKoduLabel.text = "POSTA KODU"
        postaKoduLabel.font = UIFont.systemFont(ofSize: 12)
        postaKoduLabel.textColor = .gray
        postaKoduLabel.isHidden = true
        postaKoduLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(postaKoduLabel)
        
        postaKoduText.placeholder = "POSTA KODU"
        postaKoduText.borderStyle = .roundedRect
        postaKoduText.delegate = self
        postaKoduText.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(postaKoduText)
        
      
            NSLayoutConstraint.activate([
                ilLabel.leadingAnchor.constraint(equalTo: ilField.leadingAnchor),
                ilLabel.bottomAnchor.constraint(equalTo: ilField.topAnchor),
                
                ilField.topAnchor.constraint(equalTo: buton1.bottomAnchor, constant: 15),
                ilField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                ilField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                ilceLabel.leadingAnchor.constraint(equalTo: ilceText.leadingAnchor),
                ilceLabel.bottomAnchor.constraint(equalTo: ilceText.topAnchor),
                
                ilceText.topAnchor.constraint(equalTo: ilField.bottomAnchor, constant: 15),
                ilceText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                ilceText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                adresLabel.leadingAnchor.constraint(equalTo: adresText.leadingAnchor),
                adresLabel.bottomAnchor.constraint(equalTo: adresText.topAnchor),
                
                adresText.topAnchor.constraint(equalTo: ilceText.bottomAnchor, constant: 15),
                adresText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                adresText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                postaKoduLabel.leadingAnchor.constraint(equalTo: postaKoduText.leadingAnchor),
                postaKoduLabel.bottomAnchor.constraint(equalTo: postaKoduText.topAnchor),
                
                postaKoduText.topAnchor.constraint(equalTo: adresText.bottomAnchor, constant: 15),
                postaKoduText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                postaKoduText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                firmaAdıLabel.leadingAnchor.constraint(equalTo: firmaAdıText.leadingAnchor),
                firmaAdıLabel.bottomAnchor.constraint(equalTo: firmaAdıText.topAnchor),
                
                firmaAdıText.topAnchor.constraint(equalTo: postaKoduText.bottomAnchor, constant: 20),
                firmaAdıText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                firmaAdıText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                vergiDLabel.leadingAnchor.constraint(equalTo: vergiDText.leadingAnchor),
                vergiDLabel.bottomAnchor.constraint(equalTo: vergiDText.topAnchor),
                
                vergiDText.topAnchor.constraint(equalTo: firmaAdıText.bottomAnchor, constant: 15),
                vergiDText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                vergiDText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                vergiNumLabel.leadingAnchor.constraint(equalTo: vergiNumText.leadingAnchor),
                vergiNumLabel.bottomAnchor.constraint(equalTo: vergiNumText.topAnchor),
                
                vergiNumText.topAnchor.constraint(equalTo: vergiDText.bottomAnchor, constant: 15),
                vergiNumText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                vergiNumText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                
            ])

        
      
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == ilField {
            ilLabel.isHidden = false
        } else if textField == ilceText {
            ilceLabel.isHidden = false
        } else if textField == adresText {
            adresLabel.isHidden = false
        } else if textField == postaKoduText {
            postaKoduLabel.isHidden = false
        }else if textField == firmaAdıText {
            firmaAdıLabel.isHidden = false
        }else if textField == vergiDText {
            vergiDLabel.isHidden = false
        }else if textField == vergiNumText {
            vergiNumLabel.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == ilField && textField.text?.isEmpty == true {
            ilLabel.isHidden = true
        } else if textField == ilceText && textField.text?.isEmpty == true {
            ilceLabel.isHidden = true
        } else if textField == adresText && textField.text?.isEmpty == true {
            adresLabel.isHidden = true
        } else if textField == postaKoduText && textField.text?.isEmpty == true {
            postaKoduLabel.isHidden = true
        } else if textField == firmaAdıText && textField.text?.isEmpty == true {
            firmaAdıLabel.isHidden = true
        } else if textField == vergiDText && textField.text?.isEmpty == true {
            vergiDLabel.isHidden = true
        } else if textField == vergiNumText && textField.text?.isEmpty == true {
            vergiNumLabel.isHidden = true
        }
    }
    @IBAction func buton1Tapped(_ sender: Any) {
        buton1Dolu = true
        buton1.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        buton2.setImage(UIImage(systemName: "circle"), for: .normal)
        firmaAdıText.isHidden = true
        vergiDText.isHidden = true
        vergiNumText.isHidden = true
        vergiNumLabel.isHidden = true
        vergiDLabel.isHidden = true
        firmaAdıLabel.isHidden = true

    }
    
    @IBAction func buton2Tapped(_ sender: Any) {
        buton1Dolu = false
            buton2.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton1.setImage(UIImage(systemName: "circle"), for: .normal)
        firmaAdıText.isHidden = false
        vergiDText.isHidden = false
        vergiNumText.isHidden = false

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
        if let currentField = vergiNumText as? UITextField {
            currentField.resignFirstResponder()
        }
        if let currentField = postaKoduText as? UITextField {
            currentField.resignFirstResponder()
        }
        if let currentField = ilField as? UITextField {
            currentField.resignFirstResponder()
        }
        if let currentField = ilceText as? UITextField {
            currentField.resignFirstResponder()
        }
        if let currentField = adresText as? UITextField {
            currentField.resignFirstResponder()
        }
        if let currentField = vergiDText as? UITextField {
            currentField.resignFirstResponder()
        }
        if let currentField = firmaAdıText as? UITextField {
            currentField.resignFirstResponder()
        }
    }
    
    @IBAction func devamButtonClicked(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier: "odeme") as! OdemeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
