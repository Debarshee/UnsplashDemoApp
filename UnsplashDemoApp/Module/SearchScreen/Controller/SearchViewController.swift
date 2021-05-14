//
//  SearchViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
        }
    }
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var searchSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var searchTableView: UITableView! {
        didSet {
            self.searchTableView.dataSource = self
            self.searchTableView.delegate = self
            self.searchTableView.register(UINib(nibName: UserCollectionTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: UserCollectionTableViewCell.identifier)
            self.searchTableView.register(UINib(nibName: SearchUsersTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: SearchUsersTableViewCell.identifier)
        }
    }
    
    lazy var searchViewModel = SearchViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.backgroundColor = UIColor.gray
    }
    
    // MARK: - Private Functions
    private func searchedData(for searchText: String) {
        if !searchText.isEmpty {
            self.searchViewModel.getSearchedPhotoData(for: searchText)
        }
    }
    
    @IBAction private func searchSegmentControlSelected(_ sender: UISegmentedControl) {
        guard let searchedText = searchBar.text else { return }
        switch searchSegmentedControl.selectedSegmentIndex {
        case 0:
            self.searchViewModel.getSearchedPhotoData(for: searchedText)
            
        case 1:
            self.searchViewModel.getSearchedUsersData(for: searchedText)
            
        case 2:
            self.searchViewModel.getSearchedCollectionData(for: searchedText)
            
        default:
            break
        }
    }
}

// MARK: - Table DataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchSegmentedControl.selectedSegmentIndex {
        case 0:
            return self.searchViewModel.numberOfRowsInTable(section: section)
            
        case 1:
            return self.searchViewModel.numberOfRowsForUsersIn(section: section)
            
        default:
            return self.searchViewModel.numberOfRowsForCollectionIn(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchSegmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let data = searchViewModel.listDataForTable(at: indexPath.row)
            cell.configure(configurator: data)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchUsersTableViewCell.identifier, for: indexPath) as? SearchUsersTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let data = searchViewModel.usersDataForCell(at: indexPath.row)
            cell.configure(configurator: data)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCollectionTableViewCell.identifier) as? UserCollectionTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let data = searchViewModel.collectionDataForCell(at: indexPath.row)
            cell.configure(configurator: data)
            return cell
        }
    }
}

// MARK: - Table Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let userDetailViewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else { return }
        let data = searchViewModel.usersDataForCell(at: indexPath.row)
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedData(for: searchText)
    }
}

// MARK: - View Model Delegate
extension SearchViewController: SearchViewModelDelegate {
    func reloadTableData() {
        self.searchTableView.reloadData()
    }
}
