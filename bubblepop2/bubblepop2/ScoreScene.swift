//
//  ScoreScene.swift
//  bubblepop2
//
//  Created by Kunanon Pititheerachot on 5/5/18.
//  Copyright © 2018 Kunanon Pititheerachot. All rights reserved.
//

import Foundation
import SpriteKit

let defaults = UserDefaults.standard
var highScore = defaults.integer(forKey: "\(playerName)")

class ScoreScene: SKScene{
    
    override func didMove(to view: SKView) {
        
        
        let gameOverLabel = SKLabelNode()
        gameOverLabel.text = "Game Over!"
        gameOverLabel.fontName = "AvenirNext-Bold"
        gameOverLabel.fontSize = 190
        gameOverLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.75)
        gameOverLabel.fontColor = SKColor.red
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let finalScoreLabel = SKLabelNode()
        finalScoreLabel.text = "Score: \(scoreCount)"
        finalScoreLabel.fontName = "AvenirNext-Bold"
        finalScoreLabel.fontSize = 150
        finalScoreLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.55)
        finalScoreLabel.fontColor = SKColor.white
        finalScoreLabel.zPosition = 1
        self.addChild(finalScoreLabel)
        
        
        if scoreCount > highScore{
            highScore = scoreCount
            defaults.set(highScore, forKey: "\(playerName)")
        }
        
        let highScoreLabel = SKLabelNode()
        highScoreLabel.text = "\(playerName): High Score: \(highScore)"
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 90
        highScoreLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.45)
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        let restartLabel = SKLabelNode()
        restartLabel.text = "Restart"
        restartLabel.fontName = "AvenirNext-Bold"
        restartLabel.fontSize = 100
        restartLabel.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.20)
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.name = "restartButton"
        self.addChild(restartLabel)
        
        let exitLabel = SKLabelNode()
        exitLabel.text = "Exit"
        exitLabel.fontName = "AvenirNext-Bold"
        exitLabel.fontSize = 100
        exitLabel.position = CGPoint(x: self.size.width*0.70, y: self.size.height*0.20)
        exitLabel.fontColor = SKColor.white
        exitLabel.zPosition = 1
        exitLabel.name = "exitButton"
        self.addChild(exitLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            //            identify touch object or not
            let touchPosition = touch.location(in: self)
            let tappedObject = atPoint(touchPosition)
            let tappedObjectName = tappedObject.name
            
            if tappedObjectName == "restartButton"{
                self.run(clickSound)
                let moveToGameScene = GameScene(size: self.size)
                moveToGameScene.scaleMode = self.scaleMode
                let transScene = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(moveToGameScene, transition: transScene)
            }
            
            if tappedObjectName == "exitButton"{
                self.run(clickSound)
                let moveToMainScene = MainScene(size: self.size)
                moveToMainScene.scaleMode = self.scaleMode
                let transScene = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(moveToMainScene, transition: transScene)
            }
        }
    }
}
