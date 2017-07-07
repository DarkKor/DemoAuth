//
//  UIView+Frame.swift
//  DemoAuth
//
//  Created by Dmitriy on 04.11.16.
//  Copyright © 2016 GrowApp Solutions. All rights reserved.
//

import UIKit

extension UIView {
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            var origin = frame.origin
            origin.y = newValue
            frame.origin = origin
            self.frame = frame
        }
    }
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            var origin = frame.origin
            origin.x = newValue
            frame.origin = origin
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            var size = frame.size
            size.width = newValue
            frame.size = size
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            var size = frame.size
            size.height = newValue
            frame.size = size
            self.frame = frame
        }
    }
    
    var right: CGFloat {
        return self.frame.maxX
    }
    
    var bottom: CGFloat {
        return self.frame.maxY
    }
}
