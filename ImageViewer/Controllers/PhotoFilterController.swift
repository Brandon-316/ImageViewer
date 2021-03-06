//
//  PhotoFilterController.swift
//  ImageViewer
//
//  Created by Brandon Mahoney on 1/15/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class PhotoFilterController: UIViewController {
    
    private lazy var filteredImages: [UIImage] = {
        guard let image = self.photo else { return [] }
        let filteredImageBuilder = FilteredImageBuilder(image: image)
        return filteredImageBuilder.imageWithDefaultFilters()
    }()
    
    var photo: UIImage?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photo
        filtersCollectionView.dataSource = self
    }
}


extension PhotoFilterController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredImageCell.reuseIdentifier, for: indexPath) as! FilteredImageCell
        
        cell.imageView.image = filteredImages[indexPath.row]
        
        return cell
    }
}
