//
//  Resources.swift
//  PerlhuhnJagd
//
//  Created by hub on 06.01.18.
//  Copyright © 2018 hub. All rights reserved.
//

import Foundation
import SpriteKit

final class Resources {
    private var targetImages = [NSImage]()
    
    // Can't init is singleton
    private init() {
        //set the image of the target
        print("initializing Resources")
//        self.targetImages.append(#imageLiteral(resourceName: "20170906_115211"))
//        self.targetImages.append(#imageLiteral(resourceName: "DSC00919"))
        self.targetImages.append(#imageLiteral(resourceName: "DSC00885"))
        self.targetImages.append(#imageLiteral(resourceName: "DSC00885"))
        self.targetImages.append(#imageLiteral(resourceName: "DSC00885"))
    }
    
    // MARK: Shared Instance
    static let shared = Resources()
    
    // MARK: Local Variable
    var emptyStringArray : [String] = []
    
    var randomTargetImage: NSImage {
        get{
            print("randomTargetImage called")
            let imageIndex : Int = Int.randomFromRange(range: Range(0 ... targetImages.count - 1))
            let image = targetImages[imageIndex]
            return image
        }
    }
    
    
    
    
}
