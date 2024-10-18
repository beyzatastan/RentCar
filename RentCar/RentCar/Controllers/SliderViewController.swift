import UIKit

class SliderViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let imageNames = ["lale", "bas", "kule"] // Resim isimlerini buraya ekleyin
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        if let firstVC = viewControllerAtIndex(0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Otomatik kaydırma için zamanlayıcı
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
    }

    @objc func autoSlide() {
        currentIndex = (currentIndex + 1) % imageNames.count
        if let nextVC = viewControllerAtIndex(currentIndex) {
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= imageNames.count || index < 0 {
            return nil
        }

        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ImageContentViewController") as! ImageContentViewController
        contentVC.imageName = imageNames[index]
        contentVC.pageIndex = index
        return contentVC
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ImageContentViewController).pageIndex
        index += 1
        return viewControllerAtIndex(index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ImageContentViewController).pageIndex
        index -= 1
        return viewControllerAtIndex(index)
    }
}
class ImageContentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName: String = ""
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imageName)
    }
}
