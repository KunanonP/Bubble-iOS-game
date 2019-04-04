//
//  GameScene.swift
//  bubblepop2
//
//  Created by Kunanon Pititheerachot on 5/5/18.
//  Copyright © 2018 Kunanon Pititheerachot. All rights reserved.
//

import SpriteKit
import GameplayKit

var scoreCount = 0

class GameScene: SKScene {
    
//    timer score highScore
    var timerGame = Timer()
    var timerCount = 60
    let timerLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    let highScoreLabel = SKLabelNode()
    var bubbleCount = 0
    let bubbleMax = 15
    let gameArea: CGRect
    let popSound = SKAction.playSoundFileNamed("button-1.wav", waitForCompletion: false)
    override init(size: CGSize){
//        create border to create playable game size
        let gameAspectRatio: CGFloat = 16.0/9.0
        let gameWidthArea = size.height / gameAspectRatio
        let gameMargin = (size.width - gameWidthArea)/2
        gameArea = CGRect(x: gameMargin, y: 0, width: gameWidthArea, height: size.height)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    random place to put new bubble
    func randomBubblePlace() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func randomBubblePlace(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
    
//    time counter
    @objc func timerCounter() {
        timerCount -= 1
        timerLabel.text = "\(timerCount)"
        if timerCount % 2 == 0 {
          spawnBubble()
        }
        if timerCount == 0 {
            gameOver()
        }
    }
    
//    to Game Over Scene
    func gameOver(){
        let moveToScoreScene = ScoreScene(size: self.size)
        moveToScoreScene.scaleMode = self.scaleMode
        let transScene = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(moveToScoreScene, transition: transScene)
    }

//    Game Starting
    override func didMove(to view: SKView) {
        scoreCount = 0
        timerGame = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        let bubble = SKSpriteNode(imageNamed:"bubble-1")
        bubble.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        bubble.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.10)
        bubble.zPosition = 3
        bubble.name = "red"
        self.addChild(bubble)
        
        let headerTime = SKLabelNode()
        headerTime.fontSize = 50
        headerTime.text = "Time"
        headerTime.fontName = "AvenirNext-Bold"
        headerTime.fontColor = SKColor.red
        headerTime.zPosition = 1
        headerTime.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.95)
        self.addChild(headerTime)
        
//        Timer Label
        timerLabel.fontSize = 150
        timerLabel.text = "60"
        timerLabel.fontColor = SKColor.white
        timerLabel.zPosition = 1
        timerLabel.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.85)
        self.addChild(timerLabel)
        
        let headerScore = SKLabelNode()
        headerScore.fontSize = 50
        headerScore.text = "Score"
        headerScore.fontName = "AvenirNext-Bold"
        headerScore.fontColor = SKColor.red
        headerScore.zPosition = 1
        headerScore.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.95)
        self.addChild(headerScore)
        
//        Score Label
        scoreLabel.fontSize = 150
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.white
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.85)
        self.addChild(scoreLabel)
        
        let headerHighScore = SKLabelNode()
        headerHighScore.fontSize = 50
        headerHighScore.text = "High Score"
        headerHighScore.fontName = "AvenirNext-Bold"
        headerHighScore.fontColor = SKColor.red
        headerHighScore.zPosition = 1
        headerHighScore.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.95)
        self.addChild(headerHighScore)
        
//        High Score
        highScoreLabel.fontSize = 150
        highScoreLabel.text = "\(highScore)"
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.85)
        self.addChild(highScoreLabel)
    }

//    spawn by counting maximum
    func spawnBubble(){
        let ableToSpawn = bubbleMax - bubbleCount
        if ableToSpawn >= 0 {
            var randomBubbleAmount = Int(arc4random_uniform(UInt32(ableToSpawn)))
            randomBubbleAmount += 1

            for _ in 0...randomBubbleAmount{
                moreBubble()
            }
        }
    }
    
//    add more bubble to screen
    func moreBubble(){
        var randomBubbleNum = Int(arc4random_uniform(100))
        randomBubbleNum += 1
        
//    random number to add bubble
        if randomBubbleNum <= 40 {
            let bubble = SKSpriteNode(imageNamed: "bubble-1")
            bubble.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.10)
            bubble.zPosition = 3
            bubble.name = "red"
//            bubble random position
            let randomAxisX = randomBubblePlace(min: gameArea.minX + bubble.size.width/2, max: gameArea.maxX - bubble.size.width/2)
            let randomAxisY = randomBubblePlace(min: gameArea.minY + bubble.size.height/2, max: gameArea.maxY*0.75 - bubble.size.height/2)
            bubble.position = CGPoint(x: randomAxisX, y: randomAxisY)
            self.addChild(bubble)
            bubbleCount += 1
            
            if randomBubbleNum % 2 == 0 {
                bubble.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: 0.50)
                    ]))
                bubbleCount -= 1
            }
            
        }else if randomBubbleNum >= 41 && randomBubbleNum <= 70{
            let bubble = SKSpriteNode(imageNamed: "bubble-2")
            bubble.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.10)
            bubble.zPosition = 3
            bubble.name = "pink"
            let randomAxisX = randomBubblePlace(min: gameArea.minX + bubble.size.width/2, max: gameArea.maxX - bubble.size.width/2)
            let randomAxisY = randomBubblePlace(min: gameArea.minY + bubble.size.height/2, max: gameArea.maxY*0.75 - bubble.size.height/2)
            bubble.position = CGPoint(x: randomAxisX, y: randomAxisY)
            self.addChild(bubble)
            bubbleCount += 1
            
            if randomBubbleNum % 2 == 0 {
                bubble.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: 0.50)
                    ]))
                bubbleCount -= 1
            }
            
        }else if randomBubbleNum >= 71 && randomBubbleNum <= 85{
            let bubble = SKSpriteNode(imageNamed: "bubble-3")
            bubble.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.10)
            bubble.zPosition = 3
            bubble.name = "green"
            let randomAxisX = randomBubblePlace(min: gameArea.minX + bubble.size.width/2, max: gameArea.maxX - bubble.size.width/2)
            let randomAxisY = randomBubblePlace(min: gameArea.minY + bubble.size.height/2, max: gameArea.maxY*0.75 - bubble.size.height/2)
            bubble.position = CGPoint(x: randomAxisX, y: randomAxisY)
            self.addChild(bubble)
            bubbleCount += 1
            
            if randomBubbleNum % 2 == 0 {
                bubble.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: 0.50)
                    ]))
                bubbleCount -= 1
            }
            
        }else if randomBubbleNum >= 86 && randomBubbleNum <= 95{
            let bubble = SKSpriteNode(imageNamed: "bubble-4")
            bubble.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.10)
            bubble.zPosition = 3
            bubble.name = "blue"
            let randomAxisX = randomBubblePlace(min: gameArea.minX + bubble.size.width/2, max: gameArea.maxX - bubble.size.width/2)
            let randomAxisY = randomBubblePlace(min: gameArea.minY + bubble.size.height/2, max: gameArea.maxY*0.75 - bubble.size.height/2)
            bubble.position = CGPoint(x: randomAxisX, y: randomAxisY)
            self.addChild(bubble)
            bubbleCount += 1
            
            if randomBubbleNum % 2 == 0 {
                bubble.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: 0.50)
                    ]))
                bubbleCount -= 1
            }
            
        }else if randomBubbleNum >= 96{
            let bubble = SKSpriteNode(imageNamed: "bubble-5")
            bubble.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.10)
            bubble.zPosition = 3
            bubble.name = "black"
            let randomAxisX = randomBubblePlace(min: gameArea.minX + bubble.size.width/2, max: gameArea.maxX - bubble.size.width/2)
            let randomAxisY = randomBubblePlace(min: gameArea.minY + bubble.size.height/2, max: gameArea.maxY*0.75 - bubble.size.height/2)
            bubble.position = CGPoint(x: randomAxisX, y: randomAxisY)
            self.addChild(bubble)
            bubbleCount += 1
            
            if  randomBubbleNum % 2 == 0 {
                bubble.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: 0.50)
                    ]))
                bubbleCount -= 1
            }
        }
    }
    
//    tapping bubble
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch: AnyObject in touches{
//            identify touch object or not
            let touchPosition = touch.location(in: self)
            let tappedObject = atPoint(touchPosition)
            let tappedObjectName = tappedObject.name

//            remove tapped bubble and put more bubbl
            if tappedObjectName == "red" {
                tappedObject.name=""
                tappedObject.run(SKAction.sequence([
                    SKAction.removeFromParent()
                    ]))
                //             scoring tapped bubble
                bubbleCount -= 1
                scoreCount += 1
                scoreLabel.text = "\(scoreCount)"
                self.run(popSound)
            }
                
 //            remove tapped bubble and put more bubbl
            else if tappedObjectName == "pink"{
                tappedObject.name=""
                tappedObject.run(SKAction.sequence([
                    SKAction.removeFromParent()
                    ]))
                bubbleCount -= 1
                scoreCount += 2
                scoreLabel.text = "\(scoreCount)"
                self.run(popSound)
                
            }else if tappedObjectName == "green"{
                tappedObject.name=""
                tappedObject.run(SKAction.sequence([
                    SKAction.removeFromParent()
                    ]))
                bubbleCount -= 1
                scoreCount += 5
                scoreLabel.text = "\(scoreCount)"
                self.run(popSound)

            }else if tappedObjectName == "blue"{
                tappedObject.name=""
                tappedObject.run(SKAction.sequence([
                    SKAction.removeFromParent()
                    ]))
                bubbleCount -= 1
                scoreCount += 8
                scoreLabel.text = "\(scoreCount)"
                self.run(popSound)
                
            }else if tappedObjectName == "black"{
                tappedObject.name=""
                tappedObject.run(SKAction.sequence([
                    SKAction.removeFromParent()
                    ]))
                bubbleCount -= 1
                scoreCount += 10
                scoreLabel.text = "\(scoreCount)"
                self.run(popSound)
            }
        }
        
    }
    
}
