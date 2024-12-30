import UIKit

class ReviewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var vitesLabel: UILabel!
    @IBOutlet weak var aracNameLabel: UILabel!
    @IBOutlet weak var surusView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var toplamFiyattLabel: UILabel!
    @IBOutlet weak var gunlukFiyatLabel: UILabel!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    @IBOutlet weak var depozitoLabel: UILabel!
    @IBOutlet weak var yolcuSayisiLabel: UILabel!
    @IBOutlet weak var aracSınıfLabel: UILabel!
    @IBOutlet weak var benzinlabel: UILabel!
    let ratingText = UITextField()
    let ratingLabel = UILabel()
    
    let yorumText = UITextField()
    let yorumLabel = UILabel()
    
    var car: [CarModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let car = car.first {
            aracNameLabel.text = "\(car.brand ?? "") \(car.model ?? "")"
            gunlukFiyatLabel.text = "Günlük Fiyat: \(car.dailyPrice)₺"
            yolcuSayisiLabel.text = "\(car.seatCount)"
            vitesLabel.text = "\(car.transmissionType)"
            benzinlabel.text = "\(car.gasType)"
            depozitoLabel.text = "\(car.deposit)₺"
            yolcuSayisiLabel.text = "\(car.seatCount)"
            
            // Eğer araç resmi varsa, resmi göster
            if let imageUrl = URL(string: car.imageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
               }
        
        
        // Rating Label Setup
        ratingLabel.text = "Yıldız"
        ratingLabel.font = UIFont.systemFont(ofSize: 12)
        ratingLabel.textColor = .gray
        ratingLabel.isHidden = true
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        surusView.addSubview(ratingLabel)
        
        // Rating TextField Setup
        ratingText.placeholder = "Yıldız"
        ratingText.borderStyle = .roundedRect
        ratingText.delegate = self
        ratingText.translatesAutoresizingMaskIntoConstraints = false
        surusView.addSubview(ratingText)
        
        // Yorum TextField Setup
        yorumText.placeholder = "Yorum"
        yorumText.borderStyle = .roundedRect
        yorumText.delegate = self
        yorumText.translatesAutoresizingMaskIntoConstraints = false
        surusView.addSubview(yorumText)
        
        // Yorum Label Setup
        yorumLabel.text = "Yorum"
        yorumLabel.font = UIFont.systemFont(ofSize: 12)
        yorumLabel.textColor = .gray
        yorumLabel.isHidden = true
        yorumLabel.translatesAutoresizingMaskIntoConstraints = false
        surusView.addSubview(yorumLabel)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            // Rating Label constraints
            ratingLabel.leadingAnchor.constraint(equalTo: ratingText.leadingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: ratingText.topAnchor),
            
            // Rating TextField constraints
            ratingText.topAnchor.constraint(equalTo: surusView.topAnchor, constant: 15),
            ratingText.leadingAnchor.constraint(equalTo: surusView.leadingAnchor, constant: 16),
            ratingText.trailingAnchor.constraint(equalTo: surusView.trailingAnchor, constant: -16),
            
            // Yorum Label constraints
            yorumLabel.leadingAnchor.constraint(equalTo: yorumText.leadingAnchor),
            yorumLabel.bottomAnchor.constraint(equalTo: yorumText.topAnchor),
            
            // Yorum TextField constraints
            yorumText.topAnchor.constraint(equalTo: ratingText.bottomAnchor, constant: 15),
            yorumText.leadingAnchor.constraint(equalTo: surusView.leadingAnchor, constant: 16),
            yorumText.trailingAnchor.constraint(equalTo: surusView.trailingAnchor, constant: -16),
        ])
        mainView.layer.cornerRadius=10
        surusView.layer.cornerRadius=10
        toplamFiyattLabel.layer.cornerRadius=5
        toplamFiyattLabel.layer.masksToBounds=true
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

    

    // When text field editing starts
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == ratingText {
            ratingLabel.isHidden = false
        } else if textField == yorumText {
            yorumLabel.isHidden = false
        }
    }
    
    // When text field editing ends
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == ratingText && textField.text?.isEmpty == true {
            ratingLabel.isHidden = true
        } else if textField == yorumText && textField.text?.isEmpty == true {
            yorumLabel.isHidden = true
        }
    }
    @IBAction func degerlendirmeyiGonderButtonClicked(_ sender: Any) {
    }
}
