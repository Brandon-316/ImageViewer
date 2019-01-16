//
//  FilteredImageCell.swift
//  ImageViewer
//
//  Created by Brandon Mahoney on 1/15/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
import GLKit

class FilteredImageCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FilteredImageCell.self)
    
    var eagleContext: EAGLContext!
    var image: CIImage!
    
    private lazy var glkView: GLKView = {
        let view = GLKView(frame: self.contentView.frame, context: self.eagleContext)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var context: CIContext = {
        return CIContext(eaglContext: self.eagleContext)
    }()
    
    override func layoutSubviews() {
        
        contentView.addSubview(glkView)
        NSLayoutConstraint.activate([
            glkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glkView.topAnchor.constraint(equalTo: contentView.topAnchor),
            glkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

extension FilteredImageCell: GLKViewDelegate {
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        let drawableRectSize = CGSize(width: view.drawableWidth, height: view.drawableHeight)
        let drawableRect = CGRect(origin: .zero, size: drawableRectSize)
        
        context.draw(image, in: drawableRect, from: image.extent)
    }
}
