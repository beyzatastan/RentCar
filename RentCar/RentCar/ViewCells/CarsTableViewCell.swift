//
//  CarsTableViewCell.swift
//  RentCar
//
//  Created by beyza nur on 19.10.2024.
//

import UIKit

class CarsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var carsImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
class LastRidesTableViewCell: UITableViewCell{
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var lastRideImageView: UIImageView!
}
