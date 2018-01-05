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
    
    private var label : SKLabelNode?
    private var label2 : SKLabelNode?
    private var emptyNode : SKNode?
    private var spinnyNode : SKShapeNode?
    private var imageNode1 : SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Get label2 node from scene and store it for use later
        self.label2 = self.childNode(withName: "//helloLabel2") as? SKLabelNode
        if let label2 = self.label2 {
            label2.alpha = 0.0
            label2.run(SKAction.fadeIn(withDuration: 3.0))
            
        }
        
        self.emptyNode = self.childNode(withName: "//SKNodeEmptyNode") //as? SKNode
        

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
        
        self.imageNode1 = self.childNode(withName: "//SKSpriteNode1") as? SKSpriteNode
        //let currentY = self.imageNode.
        //let moveDuration : Duration
        let initY : CGFloat = -300
        let targetY : CGFloat = 300
        let runDuration : TimeInterval = 2
        let moveUp : SKAction = SKAction.moveTo(y: targetY, duration: runDuration)
        let moveDown : SKAction = SKAction.moveTo(y: initY, duration: runDuration)
        if let imageNode1 = self.imageNode1 {
            imageNode1.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 0.8),moveUp, moveDown])))
            let image = #imageLiteral(resourceName: "20171029_173331 2") //do your setup here to make a UIImage
            let texture = SKTexture(image: image)
            imageNode1.texture = texture
        }
        
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
        let mouseX = event.location(in: self).x
        let mouseY = event.location(in: self).y
        print("event.location in self: x: " + String(describing: mouseX) + " y: " + String(describing: mouseY))

        let imageNode1X =  self.imageNode1!.position.x
        let imageNode1Y =  self.imageNode1!.position.y
        print("object.location in self: x: " + String(describing: imageNode1X) + " y: " + String(describing: imageNode1Y))

        let imageNode1Xmin =  imageNode1X - self.imageNode1!.size.width / 2
        let imageNode1Xmax =  imageNode1X + self.imageNode1!.size.width / 2
        let imageNode1Ymin =  imageNode1Y - self.imageNode1!.size.height / 2
        let imageNode1Ymax =  imageNode1Y + self.imageNode1!.size.height / 2
    
        if mouseX > imageNode1Xmin && mouseX < imageNode1Xmax {
            print("X match")
        }
        if mouseY > imageNode1Ymin && mouseY < imageNode1Ymax {
            print("Y match")
        }
        if mouseX > imageNode1Xmin && mouseX < imageNode1Xmax && mouseY > imageNode1Ymin && mouseY < imageNode1Ymax {
            print("X&Y match")
        }

        
    //    let answer = dialogOKCancel(question: "Ok?", text: "Choose your answer.")

    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = NSAlertStyle.informational
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let res = alert.runModal()
        if res == NSAlertFirstButtonReturn {
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
        case 0x31:
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
