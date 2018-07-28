//
//  Image.swift
//  TestAnimation
//
//  Created by Gavrysh on 7/28/18.
//  Copyright © 2018 Stanislav Cherkasov. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func divideIntoTwoVertialParts() -> [UIImage] {
        let cgimage = self.cgImage!
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        let contextSize: CGSize = contextImage.size
        
        let leftFrame = CGRect.init(
            x: 0,
            y: 0,
            width: contextSize.width / 2.0,
            height: contextSize.height
        )
        
        let rightFrame = CGRect.init(
            x: contextSize.width / 2.0,
            y: 0,
            width: contextSize.width / 2.0,
            height: contextSize.height
        )
        
        return [
            crop(image: self, to: leftFrame),
            crop(image: self, to: rightFrame)
        ]
    }
}



func crop(image: UIImage, to frame: CGRect) -> UIImage {
    let cgimage = image.cgImage!

    // Create bitmap image from context using the rect
    let imageRef: CGImage = cgimage.cropping(to: frame)!
    
    // Create a new image based on the imageRef and rotate back to the original orientation
    let image: UIImage = UIImage(
        cgImage: imageRef,
        scale: image.scale,
        orientation: image.imageOrientation
    )
    
    return image
}
