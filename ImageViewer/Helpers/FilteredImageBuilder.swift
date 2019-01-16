//
//  FilteredImageBuilder.swift
//  ImageViewer
//
//  Created by Brandon Mahoney on 1/15/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import CoreImage
import UIKit

class FilteredImageBuilder {
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func applyFilter(_ filter: CIFilter) -> CIImage? {
        guard let inputImage = image.ciImage ?? CIImage(image: self.image) else { return nil }
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return nil }
        
        return outputImage.cropped(to: inputImage.extent)
    }
    
    func image(withFilters filters: [CIFilter]) -> [CIImage] {
        return filters.compactMap { applyFilter($0) }
    }
    
    func imageWithDefaultFilters() -> [CIImage] {
        return image(withFilters: PhotoFilters.defaultFilters)
    }
}
