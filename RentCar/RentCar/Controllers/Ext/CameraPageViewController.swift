//
//  CameraPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 30.11.2024.

import UIKit
import AVFoundation

class CameraPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCameraPermissions()
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
    
    // Kamera veya Fotoğraf Kitaplığı açılır
    @IBAction func openCamera(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        // Simülatörde veya cihazda uygun kaynağı seç
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            #if targetEnvironment(simulator)
            picker.sourceType = .photoLibrary // Simülatörde fotoğraf kitaplığı
            print("Simülatörde kamera desteklenmiyor, Fotoğraf Kitaplığı açılıyor.")
            #else
            picker.sourceType = .camera // Fiziksel cihazda kamera
            #endif
        } else {
            picker.sourceType = .photoLibrary // Kamera yoksa fotoğraf kitaplığı
            print("Kamera mevcut değil, Fotoğraf Kitaplığı açılıyor.")
        }
        
        picker.mediaTypes = ["public.image", "public.movie"] // Hem fotoğraf hem video
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // Kullanıcının seçim yaptığı durum
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            print("Seçilen fotoğraf: \(image)")
        } else if let videoURL = info[.mediaURL] as? URL {
            print("Seçilen video: \(videoURL)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Kullanıcı seçim yapmadan çıkarsa
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("Kullanıcı seçim yapmadan çıktı.")
    }
    
    // Kamera erişimi kontrolü
    private func checkCameraPermissions() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    DispatchQueue.main.async {
                        self.showPermissionAlert()
                    }
                }
            }
        }
    }
    
    // Kamera izni reddedilirse uyarı göster
    private func showPermissionAlert() {
        let alert = UIAlertController(title: "Kamera İzni Gerekli",
                                      message: "Lütfen ayarlardan uygulama için kamera izni verin.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
