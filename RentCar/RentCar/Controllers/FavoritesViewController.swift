//
//  FavoritesViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class FavoritesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let names = ["honda civic","supra"]
    let photos = ["lale","kule"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        favsView.layer.cornerRadius = 10
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "search") as! SearchViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func personButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "personal") as! PersonalPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    
}
extension FavoritesViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "favs", for: indexPath) as! FavoritesCollectionViewCell
        let imageName = photos[indexPath.row]
        cell.imageView?.image = UIImage(named: imageName)
        cell.nameText.text = names[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 160, height: 240)
        }
    
}
