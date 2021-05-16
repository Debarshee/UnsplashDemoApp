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
    var collectionDisplayViewModel: CollectionsDisplayViewModel?
    
    override func viewDidLoad() {
        collectionDisplayViewModel?.delegate = self
        super.viewDidLoad()
        collectionDisplayViewModel?.getCollectionPhotos()
    }
}

extension CollectionsDisplayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collectionDisplayViewModel?.numberOfRowsForPhotosIn(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionsDisplayTableViewCell.identifier, for: indexPath) as? CollectionsDisplayTableViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        guard let data = collectionDisplayViewModel?.photoDataForCell(at: indexPath.row) else {
            fatalError("Invalid data")
        }
        cell.configure(configurator: data)
        return cell
    }
}

extension CollectionsDisplayViewController: CollectionsDisplayViewModelDelegate {
    func reloadTable() {
        self.collectionPhotoTableView.reloadData()
    }
}
