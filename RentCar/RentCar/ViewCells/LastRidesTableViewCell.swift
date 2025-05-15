import UIKit

class LastRidesTableViewCell: UITableViewCell {
    @IBOutlet weak var lastRideImage: UIImageView!
    @IBOutlet weak var lastCarName: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var lastLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
