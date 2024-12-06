import UIKit

class RentPageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aracMarkaLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var nextButton: UIButton!
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton

        scrollView.delegate = self
        view1.layer.cornerRadius = 10
        view.bringSubviewToFront(view1)
        setupScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        nextButton.layer.cornerRadius = 10
    }

    func setupScrollView() {
        guard let image = selectedImage else { return }
        imageView.image = image
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.addSubview(imageView)
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
    }
   
}
