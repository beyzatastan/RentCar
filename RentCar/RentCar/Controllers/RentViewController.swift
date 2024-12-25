//
//  RentViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.11.2024.
//

import UIKit

class RentViewController: UIViewController {
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        setupUI()
        createDatePicker(for: alisDate)
        createDatePicker(for: birakisDate)
        createTimePicker(for: alisTime)
        createTimePicker(for: birakisTime)
        upView.layer.cornerRadius=10
        buttonView.layer.cornerRadius=10
        
        //arama kısmına basılınca
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mekanTapped))
            mekan.addGestureRecognizer(tapGesture)
        }
        @objc func mekanTapped() {
            let vc = storyboard?.instantiateViewController(identifier: "search") as! SearchPageViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    
    
    @IBAction func homeButton(_ sender: Any) {
        let homeVc=storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        navigationController?.pushViewController(homeVc, animated: false)
    }
    
    @IBAction func personButton(_ sender: Any) {
        let personVc=storyboard?.instantiateViewController(identifier: "personal") as! PersonalPageViewController
        navigationController?.pushViewController(personVc, animated: false)
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingsVc=storyboard?.instantiateViewController(identifier: "settings") as! SettingsViewController
        navigationController?.pushViewController(settingsVc, animated: false)
  
    }
    
    
    @IBAction func findButtonClicked(_ sender: Any) {
        guard let carsVv = storyboard?.instantiateViewController(withIdentifier: "cars") as? CarsViewController else {
            print("CarsViewController could not be instantiated")
            return
        }
        if let mekanPlaceholder = mekan.attributedPlaceholder?.string {
            carsVv.alisText = mekanPlaceholder
        } else {
            carsVv.alisText = "Varsayılan Text" // Placeholder yoksa bir varsayılan metin kullanabilirsiniz
        }
        if let mekanPlaceholder = mekan.attributedPlaceholder?.string {
            carsVv.birakisText = mekanPlaceholder
        } else {
            carsVv.birakisText = "Varsayılan Text" // Placeholder yoksa bir varsayılan metin kullanabilirsiniz
        }
        carsVv.birakisTimeText=birakisDate.text
        carsVv.alisTimeText=alisDate.text
        navigationController?.pushViewController(carsVv, animated: true)
    }


    
    
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
            
           
            horizontalStackView.topAnchor.constraint(equalTo: mekan.bottomAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
   
    func createDatePicker(for textField: UITextField) {
           let datePicker = UIDatePicker()
           datePicker.preferredDatePickerStyle = .wheels
           datePicker.datePickerMode = .date
           datePicker.minimumDate = Date()
           // Toolbar
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
           toolbar.setItems([doneButton], animated: true)
           
           // TextField'e tarih seçici ve toolbar ekleme
           textField.inputAccessoryView = toolbar
           textField.inputView = datePicker
       }
    
 
    func createTimePicker(for textField: UITextField) {
           let timePicker = UIDatePicker()
           timePicker.preferredDatePickerStyle = .wheels
           timePicker.datePickerMode = .time // Sadece saat seçimi
           timePicker.locale = Locale(identifier: "tr_TR") // İsteğe bağlı: Türkçe saat formatı
           
           // Toolbar
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
           toolbar.setItems([doneButton], animated: true)
           
           // TextField'e saat seçici ve toolbar ekleme
           textField.inputAccessoryView = toolbar
           textField.inputView = timePicker
       }
      
    @objc func donePressed() {
           if let activeTextField = view.findFirstResponder() as? UITextField,
              let datePicker = activeTextField.inputView as? UIDatePicker {
               let formatter = DateFormatter()
               
               // Tarih veya saat seçimine göre format belirleme
               if datePicker.datePickerMode == .date {
                   formatter.dateStyle = .medium
                   formatter.timeStyle = .none
               } else if datePicker.datePickerMode == .time {
                   formatter.dateStyle = .none
                   formatter.timeStyle = .short // Kısa saat formatı
               }
               
               activeTextField.text = formatter.string(from: datePicker.date)
           }
           self.view.endEditing(true) // Seçimi tamamla ve klavyeyi kapat
       }}

extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        for subview in self.subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
            
