import Foundation
import UIKit

class RentImagesWebServices {
    
   static let baseURL = "http://localhost:5163/api/RentImages/uploadBeforeRentalImages/"
    static let shared = RentImagesWebServices()
    
        func uploadImages(bookingId: Int, images: [UIImage], isBeforeRental: Bool, completion: @escaping (Result<String, Error>) -> Void) {
            // Resimleri base64'e çevir
            let imageBase64Strings = images.compactMap { image -> String? in
                guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
                return imageData.base64EncodedString()
            }
            
            // Kontrol et, 4 resmin base64'e dönüştürülüp dönüştürülmediğini
            guard imageBase64Strings.count == 4 else {
                completion(.failure(NSError(domain: "com.rentcar", code: 400, userInfo: [NSLocalizedDescriptionKey: "You must upload exactly 4 images."])))
                return
            }

            // DTO'yu oluştur
            let rentImageDto = AddCarImageModel(
                bookingId: bookingId,
                imageUrl1: imageBase64Strings[0],
                imageUrl2: imageBase64Strings[1],
                imageUrl3: imageBase64Strings[2],
                imageUrl4: imageBase64Strings[3]
            )

            // API endpoint'ine POST isteği yapalım
            let urlString = isBeforeRental ? "http://localhost:5163/api/RentImages/uploadBeforeRentalImages" : "http://localhost:5163/api/RentImages/uploadAfterRentalImages"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "com.rentcar", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                // DTO'yu JSON'a dönüştür
                let jsonData = try JSONEncoder().encode(rentImageDto)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    completion(.success(responseString))
                } else {
                    completion(.failure(NSError(domain: "com.rentcar", code: 500, userInfo: [NSLocalizedDescriptionKey: "Unexpected error."])))
                }
            }
            
            task.resume()
        }
    }

   
