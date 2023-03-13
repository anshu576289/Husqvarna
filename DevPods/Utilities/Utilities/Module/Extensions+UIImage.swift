//
//  Extensions+UIImage.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import UIKit

public extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
