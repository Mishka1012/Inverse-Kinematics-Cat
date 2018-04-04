//
//  GameScene.swift
//  IK Cat
//
//  Created by Apple on 5/27/15.
//  Copyright (c) 2015 Mikahil Amshei. All rights reserved.
//

//self explanatory for the most part, cat wiggles tail and cat looks at point pressed

import SpriteKit

var lowerTorso: SKNode!

class GameScene: SKScene {
    
    var animationDuration: NSTimeInterval = 0.5
    var upperTorso: SKNode!
    var upperTorsoAngleDeg: CGFloat = 0
    
    var head: SKNode!
    var headAngleDeg: CGFloat = 360
    var eye: SKNode!
    
    var tail: SKNode!
    var tailDownAngleDeg: CGFloat = 360
    var tailUpAngleDeg: CGFloat = 280
    
    func wiggleTail() {
        var tailAnimationDuration: NSTimeInterval = 2
        let tailUp = SKAction.rotateToAngle(self.tailUpAngleDeg.degreesToRadians(), duration: tailAnimationDuration)
        let tailDown = SKAction.rotateToAngle(self.tailDownAngleDeg.degreesToRadians(), duration: tailAnimationDuration)
        tail.runAction(SKAction.repeatActionForever(SKAction.sequence([tailDown, tailUp])))
    }
    
    func lookAtLocation(location: CGPoint) {
        let look = SKAction.reachTo(location, rootNode: upperTorso, duration: animationDuration)
        
        eye.runAction(look)
    }
    
    
    func lookNormal() {
        let restore = SKAction.runBlock {
            self.head.runAction(SKAction.rotateToAngle(self.headAngleDeg.degreesToRadians(), duration: self.animationDuration))
            self.upperTorso.runAction(SKAction.rotateToAngle(self.upperTorsoAngleDeg.degreesToRadians(), duration: self.animationDuration))
        }
        
        eye.runAction(restore)
        
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor.whiteColor()
        
        lowerTorso = childNodeWithName("lower_torso")
        lowerTorso.xScale = 0.5
        lowerTorso.yScale = 0.5
        lowerTorso.position = CGPoint(x: self.frame.size.width/3, y: self.frame.size.height/3)
        upperTorso = lowerTorso.childNodeWithName("upper_torso")
        head = upperTorso.childNodeWithName("head")
        eye = head.childNodeWithName("eye")
        tail = lowerTorso.childNodeWithName("tail")
        
        wiggleTail()
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            lookAtLocation(location)
            
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            lookNormal()
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
