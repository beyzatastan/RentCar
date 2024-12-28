import UIKit

class BeforePhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var mainview: UIView!
    
    
    var selectedImages: [UIImage] = []
 
    @IBOutlet weak var tableView: UITableView!
    
    // Veritabanı
    var bookingId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(upView)
        mainview.layer.cornerRadius = 10
        upView.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        print("BEFORE PHOTOS")
        print(selectedImages)
        print(bookingId ?? "No booking ID")
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
    
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        // RentImagesWebServices'i çağırarak resimleri yükle
        let imageUploadService = RentImagesWebServices()
        imageUploadService.uploadImages(bookingId: self.bookingId ?? 5, images: self.selectedImages, isBeforeRental: true) { result in
            switch result {
            case .success(let response):
                print("Images uploaded successfully: \(response)")
                let vc = self.storyboard?.instantiateViewController(identifier: "beforeResimleriKaydet") as! LastViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .failure(let error):
                print("Failed to upload images: \(error.localizedDescription)")
                // Hata durumunda kullanıcıya bir uyarı gösterebilirsiniz
                let alert = UIAlertController(title: "Error", message: "Failed to upload images. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeforePhotosTableViewCell
        cell.aracPhotoImageView.image = selectedImages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

class AfterPhotosViewController: UIViewController {
    // After photos page implementation
}
