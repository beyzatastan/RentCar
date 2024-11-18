//
//  RentViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.11.2024.
//

import UIKit

class RentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createDatePicker(for: alisDate)
        createDatePicker(for: birakisDate)
        createTimePicker(for: alisTime)
        createTimePicker(for: birakisTime)
    }
    
    // UI Elemanları
    let mekan: UITextField = {
        let textField = UITextField()
        textField.placeholder = " İl, ilçe ya da havalimanı"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .darkGray
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 9
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowRadius = 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let farkliBirakLabel: UILabel = {
        let label = UILabel()
        label.text = "Aracı farklı bir yerde bırakmak istiyorum"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let farkliBirakSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = false
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    let ikinciMekan: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Bırakılacak yer"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .darkGray
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 9
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowRadius = 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true // Başlangıçta gizli
        return textField
    }()
    
    let alisDate: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Araç Alış Tarihi"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 9
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let alisTime: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Araç Alış Saati"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 9
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birakisDate: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Araç Bırakış Tarihi"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 9
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birakisTime: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Araç Bırakış Saati"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 9
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func setupUI() {
        view.addSubview(mekan)
        view.addSubview(farkliBirakLabel)
        view.addSubview(farkliBirakSwitch)
        view.addSubview(ikinciMekan)
        
        // Tarih ve saat için stackView'ları ayarla
        let alisStackView = UIStackView(arrangedSubviews: [alisTime, alisDate])
        alisStackView.axis = .vertical
        alisStackView.spacing = 8
        alisStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let birakisStackView = UIStackView(arrangedSubviews: [birakisTime, birakisDate])
        birakisStackView.axis = .vertical
        birakisStackView.spacing = 8
        birakisStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalStackView = UIStackView(arrangedSubviews: [alisStackView, birakisStackView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 20
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalStackView)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            mekan.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            mekan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mekan.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mekan.heightAnchor.constraint(equalToConstant: 50),
            
            farkliBirakLabel.topAnchor.constraint(equalTo: mekan.bottomAnchor, constant: 20),
            farkliBirakLabel.leadingAnchor.constraint(equalTo: mekan.leadingAnchor),
            
            farkliBirakSwitch.centerYAnchor.constraint(equalTo: farkliBirakLabel.centerYAnchor),
            farkliBirakSwitch.leadingAnchor.constraint(equalTo: farkliBirakLabel.trailingAnchor, constant: 8),
            
            ikinciMekan.topAnchor.constraint(equalTo: farkliBirakLabel.bottomAnchor, constant: 20),
            ikinciMekan.leadingAnchor.constraint(equalTo: mekan.leadingAnchor),
            ikinciMekan.trailingAnchor.constraint(equalTo: mekan.trailingAnchor),
            ikinciMekan.heightAnchor.constraint(equalToConstant: 50),
            
            horizontalStackView.topAnchor.constraint(equalTo: ikinciMekan.bottomAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Switch action
        farkliBirakSwitch.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
    }
    
    @objc func toggleSwitch() {
        ikinciMekan.isHidden = !farkliBirakSwitch.isOn
    }
    
    // Date ve Time picker kurulumları (Önceden yazılmış kodlar)
    func createDatePicker(for textField: UITextField) { /* ... */ }
    func createTimePicker(for textField: UITextField) { /* ... */ }
    @objc func donePressed() { /* ... */ }
}
