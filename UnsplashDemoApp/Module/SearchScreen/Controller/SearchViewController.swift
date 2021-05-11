//
//  SearchViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import UIKit

class SearchViewController: UIViewController {

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
        }
    }
    
    lazy var searchViewModel = SearchViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.backgroundColor = UIColor.gray
    }
    
    private func searchedData(for searchText: String) {
        if !searchText.isEmpty {
            self.searchViewModel.getSearchedData(for: searchText)
        } else {
            // self.searchViewModel.fetchData(type: searchType)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchViewModel.numberOfRowsInTable(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = searchViewModel.listDataForTable(at: indexPath.row)
        cell.configure(configurator: data)
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedData(for: searchText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func reload() {
        self.searchTableView.reloadData()
    }
}
