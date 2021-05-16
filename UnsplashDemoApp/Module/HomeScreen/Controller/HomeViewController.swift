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
            self.topicCollectionView.delegate = self
        }
    }
    @IBOutlet private weak var topicCollectionContainerView: UIView!
    @IBOutlet private weak var reviewButton: UIButton!
    
    lazy var homeViewModel = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        topicCollectionView.backgroundColor = .clear
        self.showWelcomeScreen()
        homeViewModel.fetchTopicPhotos(for: "bo8jQKTaE0Y")
        homeViewModel.fetchTopicData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // let selectedIndexPath = IndexPath(item: 0, section: 0)
        // topicCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
    }
    
    @IBAction private func reviewButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let reviewViewController = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController else { return }
        self.present(reviewViewController, animated: true, completion: nil)
    }
    
    private func showWelcomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? ReviewViewController else { return }
        self.present(welcomeViewController, animated: true, completion: nil)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = homeViewModel.listDataForCollection(at: indexPath.row)
        cell.configure(configurator: data)
        switch indexPath.row {
        case 0:
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            return cell

        default:
            return cell
        }
    }
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = homeViewModel.listDataForCollection(at: indexPath.row)
        homeViewModel.fetchTopicPhotos(for: data.topicId)
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
