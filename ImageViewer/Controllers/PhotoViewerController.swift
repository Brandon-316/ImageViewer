//
//  PhotoViewerController.swift
//  ImageViewer
//
//  Created by Brandon Mahoney on 1/14/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewerController: UIViewController {
    
    var photo: Photo!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photo.image
    }
    
    
    @IBAction func launchPhotoZoomController(_ sender: Any) {
        guard let storyboard = storyboard else { return }
        let zoomController = storyboard.instantiateViewController(withIdentifier: String(describing: PhotoZoomController.self)) as! PhotoZoomController
        zoomController.modalTransitionStyle = .crossDissolve
        zoomController.photo = photo
        
        navigationController?.present(zoomController, animated: true, completion: nil)
    }
    
}
