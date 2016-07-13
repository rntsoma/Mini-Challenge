//
//  GameScene.swift
//  Challenge
//
//  Created by vntlab on 7/12/16.
//  Copyright (c) 2016 vntlab. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let bg:SKSpriteNode=SKSpriteNode.init(imageNamed: "background")
    let hero=Hero.init(imageNamed: "spaceship")
    var enemyArray:[Enemy]=[]
    let bulletCollision:UInt32 = 0x1 << 0
    let enemyCollision:UInt32 = 0x1 << 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.bg.position=CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.hero.position=CGPoint(x: 50, y: self.frame.height / 2)
        self.bg.zPosition=0
        self.hero.zPosition=1
        let waitAction=SKAction.waitForDuration(0.5)
        let spawnCreeps=SKAction.runBlock{
            self.spawnEnemies()
        }
        let sequence=SKAction.sequence([waitAction, spawnCreeps])
        self.runAction(SKAction.repeatActionForever(sequence))
        self.addChild(bg)
        self.addChild(hero)
        self.physicsWorld.contactDelegate=self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let bullet = SKSpriteNode.init(imageNamed:"projectile")
            let moveAction = SKAction.moveTo(location, duration: 0.5)
            let removeAction = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([moveAction, removeAction])            
            bullet.position = CGPointMake(hero.position.x+50, hero.position.y)
            bullet.zPosition = 2
            bullet.runAction(actionSequence)
            bullet.physicsBody=SKPhysicsBody(circleOfRadius: bullet.size.width / 2)
            bullet.physicsBody?.affectedByGravity=false
            bullet.physicsBody?.categoryBitMask=self.bulletCollision
            bullet.physicsBody?.contactTestBitMask=self.enemyCollision
            bullet.physicsBody?.collisionBitMask=self.enemyCollision
            bullet.physicsBody?.usesPreciseCollisionDetection=true
            self.addChild(bullet)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func spawnEnemies(){
        let enemy=Enemy.init(imageNamed: "monster")
        enemy.position=CGPoint(x: self.frame.width - 70, y: CGFloat(random() % Int(self.frame.height)))
        let moveAction=SKAction.moveTo(CGPoint(x: 0,y: enemy.position.y), duration: 2)
        let removeAction=SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, removeAction])
        enemy.physicsBody = SKPhysicsBody.init(rectangleOfSize: enemy.frame.size)
        enemy.physicsBody?.affectedByGravity=false
        enemy.physicsBody?.categoryBitMask=self.enemyCollision
        enemy.physicsBody?.collisionBitMask=self.bulletCollision
        enemy.physicsBody?.contactTestBitMask=self.bulletCollision
        enemy.physicsBody?.usesPreciseCollisionDetection=true
        enemy.zPosition=2
        enemy.runAction(sequence)
        self.enemyArray.append(enemy)
        self.addChild(enemy)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody=contact.bodyA.node as! SKSpriteNode
        let secondBody=contact.bodyB.node as! SKSpriteNode
        if(contact.bodyA.categoryBitMask == self.bulletCollision && contact.bodyB.categoryBitMask == self.enemyCollision){
//            print("Bateu, hue")
            firstBody.runAction(SKAction.removeFromParent())
            secondBody.runAction(SKAction.removeFromParent())
        }
        
    }
    
}
