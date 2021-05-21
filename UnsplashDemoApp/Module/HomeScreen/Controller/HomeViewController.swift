//
//  HomeViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var selectedIndex = 0
    @IBOutlet private weak var topicPhotosTableView: UITableView! {
        didSet {
            self.topicPhotosTableView.dataSource = self
            self.topicPhotosTableView.register(UINib(nibName: HomeTableViewFirstCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: HomeTableViewFirstCell.identifier)
        }
    }
    @IBOutlet private weak var topicCollectionView: UICollectionView! {
        didSet {
            self.topicCollectionView.dataSource = self
            self.topicCollectionView.delegate = self
        }
    }
    @IBOutlet private weak var topicCollectionContainerView: UIView!
    @IBOutlet private weak var reviewButton: UIButton!
    
    lazy var homeViewModel = HomeViewModel(delegate: self)
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        topicCollectionView.backgroundColor = .clear
        self.showWelcomeScreen()
        homeViewModel.fetchTopicPhotos(for: "bo8jQKTaE0Y", pageNo: currentPage)
        homeViewModel.fetchTopicData(pageNo: currentPage)
    }
    
    @IBAction private func reviewButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let reviewViewController = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController else { return }
        self.present(reviewViewController, animated: true, completion: nil)
    }
    
    private func showWelcomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else { return }
        self.present(welcomeViewController, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.numberOfRowsInTable(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == homeViewModel.photoDataCount() - 1 {
//            currentPage += 1
//            homeViewModel.extendingTopicPhotos(pageNo: currentPage)
//        }
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewFirstCell.identifier, for: indexPath) as? HomeTableViewFirstCell else {
                fatalError("Failed to dequeue the cell")
            }
            let data = homeViewModel.listDataForTable(at: indexPath.row)
            cell.configure(configurator: data)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let data = homeViewModel.listDataForTable(at: indexPath.row)
            cell.configure(configurator: data)
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
        let data = homeViewModel.selectedDataFromTable(at: indexPath.row)
        photoViewController.photoDisplayViewModel = data
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}

// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.numberOfRowsInCollection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == homeViewModel.topicDataCount() - 1 {
            currentPage += 1
            homeViewModel.extendingTopicData(pageNo: currentPage)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        if selectedIndex == indexPath.row {
            cell.cellIsNotSelected = false
        } else {
            cell.cellIsNotSelected = true
        }
        let data = homeViewModel.listDataForCollection(at: indexPath.row)
        cell.configure(configurator: data)
        return cell
    }
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentPage = 1
        self.selectedIndex = indexPath.row
        self.topicCollectionView.reloadData()
        let data = homeViewModel.listDataForCollection(at: indexPath.row)
        homeViewModel.fetchTopicPhotos(for: data.topicId, pageNo: currentPage)
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
