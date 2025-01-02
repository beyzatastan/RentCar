//
//  LastRidessTableViewCell.swift
//  RentCar
//
//  Created by beyza nur on 1.01.2025.
//

import UIKit

class LastRidessTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var lastCarName: UILabel!
    @IBOutlet weak var lastCarImageView: UIImageView!
    
    var subcribeBtn:(() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        subcribeBtn?()
    }
    
}
