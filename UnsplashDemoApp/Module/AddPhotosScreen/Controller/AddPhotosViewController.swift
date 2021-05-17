//
//  AddPhotosViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import UIKit

class AddPhotosViewController: UIViewController {

    @IBOutlet private weak var uploadedImageView: UIImageView!
    @IBOutlet private weak var uploadImageButton: UIButton!
    @IBOutlet private weak var blogCollectionView: UICollectionView! {
        didSet {
            self.blogCollectionView.dataSource = self
            self.blogCollectionView.delegate = self
        }
    }
    
    lazy var viewModel = AddPhotosViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCollectionData()
    }
}

// MARK: - Collection Data Source
extension AddPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInCollection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as? BlogCollectionViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = viewModel.listDataForCollection(at: indexPath.row)
        cell.configure(configurator: data)
        return cell
    }
}

extension AddPhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.listDataForCollection(at: indexPath.row)
        print(data.html)
        if let url = URL(string: data.html) {
            UIApplication.shared.open(url)
        }
    }
}

extension AddPhotosViewController: AddPhotosViewModelDelegate {
    func reload() {
        self.blogCollectionView.reloadData()
    }
}
