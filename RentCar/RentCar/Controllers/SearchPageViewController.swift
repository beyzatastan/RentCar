//
//  SearchPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 30.11.2024.
//
import UIKit

class SearchPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var cities: [City] = []
    var filteredCities: [City] = []
    var cityViewModel = CityViewModel()
    var selectedCity: City?

    
    var caseNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.backButtonTitle = ""
        
        cityViewModel.fetchCities {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            // Şehirler alındıktan sonra veriyi güncelle
            self.cities = self.cityViewModel.cities
            self.filteredCities = self.cityViewModel.cities
            
            /*  // Veriler geldikten sonra, şehir ve ilçeleri konsola yazdır
             for city in self.cityViewModel.cities {
             print("Şehir adı: \(city.name), Şehir ID: \(city.id)")
             for district in city.districts {
             print("İlçe adı: \(district.name), İlçe ID: \(district.id)")
             }
             } */
        }
        // Özel UIButton oluştur
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Dikey konum için transform uygula
        backButton.transform = CGAffineTransform(translationX: 0, y: -5) // `y: -5` butonu yukarı taşır
        
        // UIBarButtonItem olarak ekle
        let barButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupUI() {
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
    // UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredCities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = filteredCities[indexPath.row]
        print("Seçilen şehir: \(city.name)")
            self.selectedCity = city
            let vc = storyboard?.instantiateViewController(identifier: "rent") as! RentViewController
            vc.mekan.attributedPlaceholder = NSAttributedString(
                string: "  \(selectedCity?.name ?? " ")",
                attributes: [
                    .foregroundColor: UIColor.black // Burada istediğiniz rengi belirleyin
                ]
            )
            navigationController?.pushViewController(vc, animated: false)
            
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCities = cities // Eğer arama boşsa tüm şehirleri göster
        } else {
            filteredCities = cities.filter { city in
                // Şehir adı veya ilçelerden herhangi biri arama metnini içeriyorsa göster
                city.name.lowercased().contains(searchText.lowercased()) ||
                city.districts.contains { district in
                    district.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
        tableView.reloadData()
    }
}
