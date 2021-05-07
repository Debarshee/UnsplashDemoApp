//
//  HomeViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var topicsCollectionView: UICollectionView!
    @IBOutlet private weak var topicPhotosTableView: UITableView! {
        didSet {
            self.topicPhotosTableView.dataSource = self
        }
    }
    lazy var homeViewModel = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.fetchData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = homeViewModel.listData(at: indexPath.row)
        cell.configure(configurator: data)
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        self.topicPhotosTableView.reloadData()
    }
}
