//
//  UIImage++.swift
//  HuaFanDay
//
//  Created by user on 2020/11/16.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import UIKit

extension UIImage {
    
    func withPadding(_ padding: UIEdgeInsets) -> UIImage {
        
        let adjustSizeForBetterHorizontalAlignment: CGSize = CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom
        )
        
        let image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(adjustSizeForBetterHorizontalAlignment, false, 0)
        draw(at: CGPoint(x: padding.left, y: padding.top))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
