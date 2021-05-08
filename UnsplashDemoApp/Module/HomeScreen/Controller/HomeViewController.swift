//
//  HomeViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var topicPhotosTableView: UITableView! {
        didSet {
            self.topicPhotosTableView.dataSource = self
        }
    }
    @IBOutlet private weak var topicCollectionView: UICollectionView! {
        didSet {
            self.topicCollectionView.dataSource = self
        }
    }
    
    lazy var homeViewModel = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        topicCollectionView.backgroundColor = .clear
        homeViewModel.fetchPhotoData()
        homeViewModel.fetchTopicData()
    }
}

// MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.numberOfRowsInTable(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = homeViewModel.listDataForTable(at: indexPath.row)
        cell.configure(configurator: data)
        return cell
    }
}

// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        return cell
    }
}

// MARK: - HomeViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    func reloadTableData() {
        self.topicPhotosTableView.reloadData()
    }
    
    func reloadCollectionData() {
        self.topicCollectionView.reloadData()
    }
}
