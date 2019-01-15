//
//  PhotoPageController.swift
//  ImageViewer
//
//  Created by Brandon Mahoney on 1/14/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
import CoreData

final class PhotoListController: UIViewController {
    
    //MARK: Properties
    let context = CoreDataStack().managedObjectContext
    
    lazy var dataSource: PhotosDataSource = {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        return PhotosDataSource(fetchRequest: request, managedObjectContext: self.context, collectionView: self.photosCollectionView)
    }()
    
    lazy var photoPickerManager: PhotoPickerManager = {
        let manager = PhotoPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    
    //MARK: Outlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.dataSource = dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let cell = sender as? UICollectionViewCell, let indexPath = photosCollectionView.indexPath(for: cell), let pageViewController = segue.destination as? PhotoPageController {
                
                pageViewController.photos = dataSource.photos
                pageViewController.indexOfCurrentPhoto = indexPath.row
            }
        }
    }
    
    
    //MARK: Actions
    @IBAction func launchCamera(_ sender: Any) {
        photoPickerManager.presentPhotoPicker(animated: true)
    }
    
}


//MARK: Extension
extension PhotoListController: PhotoPickerManagerDelegate {
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
//        let _ = Photo.with(image, in: context)
//        context.saveChanges()
        manager.dissmissPhotoPicker(animated: true) {
            guard let photoFilterController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFilterController") as? PhotoFilterController else { return }
            photoFilterController.photo = image
            
            let navController = UINavigationController(rootViewController: photoFilterController)
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }
}
