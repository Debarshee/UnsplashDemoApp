//
//  CollectionsDisplayViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import UIKit

class CollectionsDisplayViewController: UIViewController {
    
    @IBOutlet private weak var collectionPhotoTableView: UITableView! {
        didSet {
            self.collectionPhotoTableView.dataSource = self
        }
    }
    lazy var collectionDisplayViewModel = CollectionsDisplayViewModel(delegate: self)
    var selectedUsername: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = selectedUsername else {
            return
        }
        collectionDisplayViewModel.getCollectionPhotos(for: username)
    }
}

extension CollectionsDisplayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collectionDisplayViewModel.numberOfRowsForPhotosIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionsDisplayTableViewCell.identifier, for: indexPath) as? CollectionsDisplayTableViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = collectionDisplayViewModel.photoDataForCell(at: indexPath.row)
        cell.configure(configurator: data)
        return cell
    }
}

extension CollectionsDisplayViewController: CollectionsDisplayViewModelDelegate {
    func reloadTable() {
        self.collectionPhotoTableView.reloadData()
    }
}
