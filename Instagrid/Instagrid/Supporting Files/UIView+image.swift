//
//  UIView+image.swift
//  Instagrid
//
//  Created by Nicolas Hecker on 13/07/2023.
//

import UIKit

extension UIView {
    func convertViewToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
