import UIKit

class Search2PageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    var cities: [LocationModel] = []
    var filteredCities: [LocationModel] = []
    var locationViewModel = LocationViewModel()
    var selectedCity: LocationModel?
    
    //r4entpage için
    var selectedİkinciMekan: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        fetchCities()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let rentVC = navigationController?.viewControllers.first(where: { $0 is RentViewController }) as? RentViewController {
            rentVC.selectedIkinciMekan = self.selectedİkinciMekan // Pass back selected city or any value
            rentVC.farkliBirakSwitch.isOn = true // Preserve switch state (if needed)
            rentVC.ikinciMekan.isHidden = false
            rentVC.ikinciMekan.text = self.selectedİkinciMekan // Set the second location text field value
        }
    }


    private func setupNavigationBar() {
        navigationItem.backButtonTitle = ""

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.transform = CGAffineTransform(translationX: 0, y: -5)

        let barButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButtonItem
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func fetchCities() {
        locationViewModel.getLocation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    self?.cities = locations
                    self?.filteredCities = locations
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("API Hatası: \(error.localizedDescription)")
                }
            }
        }
    }

    private func setupUI() {
        // Search Bar
        searchBar.delegate = self
        searchBar.placeholder = "Şehir veya ilçe ara"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)

        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // Layout
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredCities[indexPath.row].city
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = filteredCities[indexPath.row]
        self.selectedCity = city

        // Update selectedMekan to be passed back to RentViewController
        self.selectedİkinciMekan = city.city
        
        // RentViewController'a git
        if let vc = storyboard?.instantiateViewController(identifier: "rent") as? RentViewController {
            vc.mekan.attributedPlaceholder = NSAttributedString(
                string: "  \(self.selectedİkinciMekan ?? "")",
                attributes: [
                    .foregroundColor: UIColor.black
                ]
              
            )
            vc.ikinciMekan.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { city in
                city.city.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
