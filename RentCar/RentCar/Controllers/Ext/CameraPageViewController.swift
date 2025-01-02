//import UIKit
import AVFoundation
import PhotosUI

class CameraPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    var selectedImages: [UIImage] = []
    
    //veritabanı
    var bookingId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        selectImages()
        
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
    
    func selectImages() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 4 - selectedImages.count  // Seçilebilecek resim sayısını kısıtla
        config.filter = .images  // Sadece resimleri seç
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let dispatchGroup = DispatchGroup() // Görüntülerin yüklenmesini takip etmek için DispatchGroup
        
        for result in results {
            dispatchGroup.enter() // İşlemi başlat
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                defer { dispatchGroup.leave() } // İşlem tamamlanınca çık
                
                if let image = object as? UIImage {
                    self?.selectedImages.append(image) // Resmi diziye ekle
                } else if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            picker.dismiss(animated: true, completion: nil) // Picker'ı kapat
            
            print("Tüm işlemler tamamlandı, geçiş yapılacak") // Debugging mesajı
            
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let nextVC = storyboard.instantiateViewController(withIdentifier: "beforePhotos") as? BeforePhotosViewController {
                nextVC.selectedImages = self.selectedImages
                nextVC.bookingId = self.bookingId
                
                print("Veriler geçirildi, sayfaya geçiliyor") // Debugging mesajı
                navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

/*
 //
 //  CameraPageViewController.swift
 //  RentCar
 //
 //  Created by beyza nur on 30.11.2024.

 import UIKit
 import AVFoundation
 import PhotosUI
 class CameraPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
     
     var selectedImages: [UIImage] = []
     var bookingId: Int?
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         navigationItem.backButtonTitle = ""
         selectImages()
     }

     func selectImages() {
         var config = PHPickerConfiguration()
         config.selectionLimit = 4 - selectedImages.count  // Seçilebilecek resim sayısını kısıtla
         config.filter = .images  // Sadece resimleri seç
         let picker = PHPickerViewController(configuration: config)
         picker.delegate = self
         present(picker, animated: true)
     }
     
     func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
         let dispatchGroup = DispatchGroup() // Görüntülerin yüklenmesini takip etmek için DispatchGroup
         
         for result in results {
             dispatchGroup.enter() // İşlemi başlat
             result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                 defer { dispatchGroup.leave() } // İşlem tamamlanınca çık
                 
                 if let image = object as? UIImage {
                     self?.selectedImages.append(image) // Resmi diziye ekle
                 } else if let error = error {
                     print("Error loading image: \(error.localizedDescription)")
                 }
             }
         }
         
         // Tüm işlemler tamamlandıktan sonra çalıştır
         dispatchGroup.notify(queue: .main) { [weak self] in
             picker.dismiss(animated: true, completion: nil) // Picker'ı kapat
             
             // Diğer sayfaya geçiş
             guard let self = self else { return }
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             
             if let nextVC = storyboard.instantiateViewController(withIdentifier: "beforePhotos") as? BeforePhotosViewController {
                 nextVC.selectedImages = self.selectedImages
                 nextVC.bookingId = self.bookingId
                 
                 // Seçilen görüntüleri geçir
                 print(self.selectedImages)
                 self.navigationController?.pushViewController(nextVC, animated: true)
             }
         }
     }
     
     func uploadBeforeRentalImages() {
         guard let bookingId = bookingId else { return }
         
         RentImagesWebServices.uploadBeforeRentalImages(bookingId: bookingId, images: selectedImages) { result in
             switch result {
             case .success(let message):
                 print(message)
             case .failure(let error):
                 print("Error uploading images: \(error.localizedDescription)")
             }
         }
     }
     
     func uploadAfterRentalImages() {
         guard let bookingId = bookingId else { return }
         
         RentImagesWebServices.shared.uploadAfterRentalImages(bookingId: bookingId, images: selectedImages) { result in
             switch result {
             case .success(let message):
                 print(message)
             case .failure(let error):
                 print("Error uploading images: \(error.localizedDescription)")
             }
         }
     }
 }

 */
