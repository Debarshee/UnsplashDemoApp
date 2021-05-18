//
//  CollectionsDisplayViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import UIKit

class CollectionsDisplayViewController: UIViewController {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var shareCollectionButton: UIButton!
    @IBOutlet private weak var collectionPhotoTableView: UITableView! {
        didSet {
            self.collectionPhotoTableView.dataSource = self
            self.collectionPhotoTableView.delegate = self
        }
    }
    var collectionDisplayViewModel: CollectionsDisplayViewModel?
    
    override func viewDidLoad() {
        collectionDisplayViewModel?.delegate = self
        super.viewDidLoad()
        collectionDisplayViewModel?.getCollectionPhotos()
    }
    
    @IBAction private func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func shareCollectionButtonClicked(_ sender: UIButton) {
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

extension CollectionsDisplayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
        guard let data = collectionDisplayViewModel?.photoDataForCell(at: indexPath.row) else { return }
        let photo = collectionDisplayViewModel?.passPhotoData(photoData: data.photoCollectionData)
        photoViewController.photoDisplayViewModel = photo
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}

extension CollectionsDisplayViewController: CollectionsDisplayViewModelDelegate {
    func reloadTable() {
        self.collectionPhotoTableView.reloadData()
    }
}
