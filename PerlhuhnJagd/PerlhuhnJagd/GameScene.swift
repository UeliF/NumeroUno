//
//  GameScene.swift
//  PerlhuhnJagd
//
//  Created by hub on 31.12.17.
//  Copyright © 2017 hub. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreFoundation




class GameScene: SKScene {
    
    private var labelShotCount : SKLabelNode?
    private var emptyNode : SKNode?
    private var spinnyNode : SKShapeNode?
    private var SKSpriteNodeBGB : SKSpriteNode?
    private var SKSpriteNodeBGT : SKSpriteNode?
    
    var targets = [HBSpriteNode]()
    var count : Int = 0;
    
    fileprivate func manageSKSpriteNodeTargets() {
        for number in 1...3 {
            manageSKSpriteNodeTarget(number: number)
        }
    }
    
    fileprivate func manageSKSpriteNodeTarget(number: Int) {
        //position the target and run its actions
        let target = self.childNode(withName: "//SKSpriteNodeTarget" + String(number)) as! HBSpriteNode
        target.activate(GameScene: self)
        targets.append(target)
    }
    
    fileprivate func setBackgroundTextures() {
        self.SKSpriteNodeBGB = self.childNode(withName: "//SKSpriteNodeBGB") as? SKSpriteNode
        let imageBottom =  #imageLiteral(resourceName: "2017-10-05 15.35.18 Unten")//do your setup here to make a UIImage
        let textureBottom = SKTexture(image: imageBottom)
        SKSpriteNodeBGB!.texture = textureBottom
        SKSpriteNodeBGB!.size = self.size
        
        self.SKSpriteNodeBGT = self.childNode(withName: "//SKSpriteNodeBGT") as? SKSpriteNode
        let imageTop =  #imageLiteral(resourceName: "2017-10-05 15.35.18 Oben")//do your setup here to make a UIImage
        let textureTop = SKTexture(image: imageTop)
        SKSpriteNodeBGT!.texture = textureTop
        SKSpriteNodeBGT!.size = self.size
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.labelShotCount = self.childNode(withName: "//LabelShotCount") as? SKLabelNode
        if let labelShotCount = self.labelShotCount {
            labelShotCount.alpha = 0.0
            labelShotCount.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.emptyNode = self.childNode(withName: "//SKNodeEmptyNode")
        
        setBackgroundTextures()

        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        manageSKSpriteNodeTargets()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))

        print("shot location: x: \(event.location(in: self).x) y: \(event.location(in: self).y)")

        //check if cursor clicked on a target
        for target in targets {
            count += target.evaluateShot(shotLocation: event.location(in: self))
            if let labelShotCount = self.labelShotCount {
                labelShotCount.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
            self.labelShotCount!.text = "\(count) Points!"
            
        }

        
    //    let answer = dialogOKCancel(question: "Ok?", text: "Choose your answer.")

    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = NSAlert.Style.informational
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let res = alert.runModal()
        if res == NSApplication.ModalResponse.alertFirstButtonReturn {
            return true
        }
        return false
    }
    
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:  // space pressed
            if let labelShotCount = self.labelShotCount {
                labelShotCount.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
