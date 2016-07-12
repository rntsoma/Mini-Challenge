//
//  GameScene.swift
//  Challenge
//
//  Created by vntlab on 7/12/16.
//  Copyright (c) 2016 vntlab. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let bg:SKSpriteNode=SKSpriteNode.init(imageNamed: "background")
    let hero:SKSpriteNode=SKSpriteNode.init(imageNamed: "spaceship")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        bg.position=CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        hero.position=CGPoint(x: 50, y: self.frame.height / 2)
        //bullet.position=CGPoint(x: 50, y: self.frame.height / 2)
        self.addChild(bg)
        self.addChild(hero)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let bullet = SKSpriteNode.init(imageNamed:"projectile")
            
            
            
            bullet.position = CGPointMake(hero.position.x+50, hero.position.y)
            bullet.zPosition = 2
//            bullet.position=CGPoint(x:100, y:100)
            
//            let action = SKAction.moveTo(location, duration: 0.5)
//            
//            bullet.runAction(action)
//            hero.runAction(action)
            self.addChild(bullet)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
