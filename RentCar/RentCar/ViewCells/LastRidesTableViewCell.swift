import UIKit

protocol LastRidesTableViewCellDelegate: AnyObject {
    func didTapEvaluateButton(at index: Int)
}

class LastRidesTableViewCell: UITableViewCell {
    @IBOutlet weak var lastRideImage: UIImageView!
    @IBOutlet weak var lastCarName: UILabel!
    weak var delegate: LastRidesTableViewCellDelegate?
       var index: Int? // To store the index of the cell
       
       @IBAction func degerlendiRButtonClicked(_ sender: Any) {
           if let index = index {
               delegate?.didTapEvaluateButton(at: index) // Delegate metodunu çağır
           }
       }
}
