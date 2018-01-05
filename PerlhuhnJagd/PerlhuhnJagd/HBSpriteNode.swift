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
    private var windowNumericHeight : Int = 0;
    private var windowNumericWidth : Int = 0
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
        let initY : CGFloat = CGFloat(-windowNumericHeight)
        
        //set the 'appear' Y position to a random position between the middle and top from the window
        let targetY : CGFloat = CGFloat(Int.randomFromRange(range: Range<Int>(0 ... windowNumericHeight)))
        
        //set the 'appear' X position to a random position in the widht from the window
        let targetX : CGFloat = CGFloat(Int.randomFromRange(range: Range<Int>(-windowNumericWidth ... windowNumericWidth)))

        let runDuration : TimeInterval = TimeInterval(CGFloat(Int.randomFromRange(range: Range<Int>(40 ... 140))) / 100)
        let waitDuration : TimeInterval = TimeInterval(CGFloat(Int.randomFromRange(range: Range<Int>(40 ... 100))) / 100)
        let moveUp : SKAction = SKAction.moveTo(y: targetY, duration: runDuration)
        let moveDown : SKAction = SKAction.moveTo(y: initY, duration: runDuration)
        let moveSideways : SKAction = SKAction.moveTo(x: targetX, duration: 0)
        
        //self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: waitDuration),moveUp, moveDown])))
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: waitDuration), moveUp, moveDown, moveSideways, SKAction.unhide()])) {
            //run again when done
            self.runActions()
        }
        
    }
    
    func evaluateShot(shotLocation: CGPoint) -> Int {    
        let shotX = shotLocation.x
        let shotY = shotLocation.y
        
        let targetX =  self.position.x
        let targetY =  self.position.y
        let targetName = self.name!
        print("target \(targetName) location: x: \(targetX as CGFloat) y: \(targetY as CGFloat)")
        
        let imageNode1Xmin =  targetX - self.size.width / 2
        let imageNode1Xmax =  targetX + self.size.width / 2
        let imageNode1Ymin =  targetY - self.size.height / 2
        let imageNode1Ymax =  targetY + self.size.height / 2
        
        //            if mouseX > imageNode1Xmin && mouseX < imageNode1Xmax {
        //                print("X match")
        //            }
        //            if mouseY > imageNode1Ymin && mouseY < imageNode1Ymax {
        //                print("Y match")
        //            }
        if shotX > imageNode1Xmin && shotX < imageNode1Xmax && shotY > imageNode1Ymin && shotY < imageNode1Ymax {
            let theShotValue = self.getShotValue()
            print("X&Y match on \(targetName) with ShotCount \(theShotValue)")
            return theShotValue
        }
        return 0
    }
    
    private func getShotValue() -> Int {
        
        if(actionRunCount != lastShotActionRunCount){
            // it is a proper shot, well done :-)
            print("target shot in new actionRunCount \(actionRunCount), returning \(shotValue) points")
            lastShotActionRunCount = actionRunCount
            // play a sound here! :-)
            self.run(SKAction.hide())
            return shotValue
        }
        else
        {
            // it is a repeated shot. no points for that, sorry :-(
            print("target shot in same actionRunCount, returning 0 points")
            return 0;
        }
    }
    
    func activate(GameScene: GameScene){
        self.windowNumericHeight = Int(GameScene.size.height) / 2
        self.windowNumericWidth = Int(GameScene.size.width) / 2
        print("activating target \(self.name!) with windowNumericHeight \(windowNumericHeight)")
        runActions()
    }
    
    required init(coder aCoder: NSCoder){
        super.init(coder: aCoder)!
        
        setTexture()
    }
}

