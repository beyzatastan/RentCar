import UIKit
class SearchPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var cities: [LocationModel] = []
    var filteredCities: [LocationModel] = []
    var locationViewModel = LocationViewModel()
    var selectedCity: LocationModel?
    
    var selectedLocation: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        fetchCities()
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
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
    }

    private func setupUI() {
        // Search Bar
        searchBar.delegate = self
        searchBar.placeholder = "Search city or district"
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
        self.selectedLocation = city.city

        // Pass back to RentViewController
        if let vc = storyboard?.instantiateViewController(identifier: "rent") as? RentViewController {
                vc.mekan.attributedPlaceholder = NSAttributedString(
                    string: "  \(city.city)",
                    attributes: [
                        .foregroundColor: UIColor.black
                    ]
                )
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
