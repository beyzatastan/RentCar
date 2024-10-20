//
//  AddCarViewController.swift
//  RentCar
//
//  Created by beyza nur on 21.10.2024.
//

import UIKit

class AddCarViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        collectionView.dataSource=self
        collectionView.delegate=self
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addphotoButton(_ sender: Any) {
        
    }
    
}
extension AddCarViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carphotos", for: indexPath) as! CarPhotosCollectionViewCell
        cell.imageView?.image=UIImage(named: "bmw")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 90, height: 81)
        }
    
}
