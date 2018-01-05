//
//  HBSpriteNode.swift
//  PerlhuhnJagd
//
//  Created by hub on 05.01.18.
//  Copyright © 2018 hub. All rights reserved.
//

import SpriteKit

class HBSpriteNode: SKSpriteNode {
    
    let ShotCount : Int = Int.randomFromRange(range: Range(10 ... 30))
    
    fileprivate func setTexture() {
        let image =  #imageLiteral(resourceName: "DSC00885")//do your setup here to make a UIImage
        let texture = SKTexture(image: image)
        self.texture = texture
    }
    
    required init(coder: NSCoder){
        super.init(coder: coder)!
        
        setTexture()
    }
}

