//
//  HBSpriteNode.swift
//  PerlhuhnJagd
//
//  Created by hub on 05.01.18.
//  Copyright © 2018 hub. All rights reserved.
//

import SpriteKit

class HBSpriteNode: SKSpriteNode {
    
    private let shotValue : Int = Int.randomFromRange(range: Range(10 ... 30))
    private var windowNumericHeight : CGFloat = CGFloat();
    private var actionRunCount : Int = 0;
    private var lastShotActionRunCount : Int = 0;

    fileprivate func setTexture() {
        //set the image of the target
        let image =  #imageLiteral(resourceName: "DSC00885")//do your setup here to make a UIImage
        let texture = SKTexture(image: image)
        self.texture = texture
    }
    
    fileprivate func runActions() {
        //run actions once, then call recursively
        actionRunCount += 1;
        
        //set the 'wait' position to the bottom of the window  (x:0,y:0 is the center of the window)
        let initY : CGFloat = -windowNumericHeight
        
        //set the 'appear' Y position to a random position between the middle and top from the window
        let targetY : CGFloat = CGFloat(Int.randomFromRange(range: Range<Int>(0 ... Int(windowNumericHeight))))
        
        //set the 'appear' X position to a random position away from the current position
        let targetX : CGFloat = self.position.x + CGFloat(Int.randomFromRange(range: Range<Int>(-100 ... 100)))

        let runDuration : TimeInterval = TimeInterval(CGFloat(Int.randomFromRange(range: Range<Int>(20 ... 200))) / 100)
        let waitDuration : TimeInterval = TimeInterval(CGFloat(Int.randomFromRange(range: Range<Int>(20 ... 100))) / 100)
        //x: targetX, 
        let moveUp : SKAction = SKAction.moveTo(y: targetY, duration: runDuration)
        let moveDown : SKAction = SKAction.moveTo(y: initY, duration: runDuration)
        
        //self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: waitDuration),moveUp, moveDown])))
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: waitDuration),moveUp, moveDown])) {
            //run again when done
            self.runActions()
        }
        
    }
    
    func getShotValue() -> Int {
        
        if(actionRunCount != lastShotActionRunCount){
            print("target shot in new actionRunCount \(actionRunCount), returning \(shotValue) points")
            lastShotActionRunCount = actionRunCount
            return shotValue
        }
        else
        {
            print("target shot in same actionRunCount, returning 0 points")
            return 0;
        }
    }
    
    func activate(windowNumericHeight: CGFloat){
        print("activating \(self.name!) with windowNumericHeight \(windowNumericHeight)")
        self.windowNumericHeight = windowNumericHeight
        runActions()
    }
    
    required init(coder aCoder: NSCoder){
        super.init(coder: aCoder)!
        
        setTexture()
    }
}

