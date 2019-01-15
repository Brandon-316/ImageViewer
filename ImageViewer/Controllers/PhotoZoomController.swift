//
//  PhotoZoomController.swift
//  ImageViewer
//
//  Created by Brandon Mahoney on 1/14/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class PhotoZoomController: UIViewController {
    
    var photo: Photo!
    
    var minZoomScale: CGFloat {
        let viewSize = view.bounds.size
        let widthScale = viewSize.width/photoImageView.bounds.width
        let heightScale = viewSize.height/photoImageView.bounds.height
        
        return min(widthScale, heightScale)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = photo.image
        photoImageView.sizeToFit()
        scrollView.contentSize = photoImageView.bounds.size
        updateZoomScale()
        updateConstraintsForSize(view.bounds.size)
        view.backgroundColor = .black
    }
    
    func updateZoomScale() {
        scrollView.minimumZoomScale = minZoomScale
        scrollView.zoomScale = minZoomScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let verticalSpace = size.height - photoImageView.frame.height
        let yOffset = max(0, verticalSpace/2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - photoImageView.frame.width)/2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
    }
    
}


extension PhotoZoomController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
        
        if scrollView.zoomScale < minZoomScale {
            dismiss(animated: true, completion: nil)
        }
    }
}
