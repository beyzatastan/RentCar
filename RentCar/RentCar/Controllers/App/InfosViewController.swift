//
//  InfosViewController.swift
//  RentCar
//
//  Created by beyza nur on 20.11.2024.
//

import UIKit

class InfosViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    var currentIndex = 0
    var selectedCase: String?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var altView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upView.layer.cornerRadius = 20
        altView.layer.cornerRadius = 10
        view.sendSubviewToBack(mainView)
         updateContent(for: selectedCase)

    }
    func updateContent(for selectedCase: String?) {
          // Eski içeriği kaldır
        mainView.subviews.forEach { $0.removeFromSuperview() }

          guard let selectedCase = selectedCase else { return }
          switch selectedCase {
          case "0":
              labelText.text = "Bu Case 1 Görünümü"
              labelText.textColor = .blue
          default:
              labelText.text = "Varsayılan Görünüm"
              labelText.textColor = .black
          }
          NSLayoutConstraint.activate([
            labelText.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            labelText.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
          ])
      }
  
}
