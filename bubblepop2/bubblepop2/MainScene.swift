//
//  MainScene.swift
//  bubblepop2
//
//  Created by Kunanon Pititheerachot on 5/5/18.
//  Copyright © 2018 Kunanon Pititheerachot. All rights reserved.
//

import Foundation
import SpriteKit

var playerName = ""
let clickSound = SKAction.playSoundFileNamed("button-2.wav", waitForCompletion: false)

class MainScene: SKScene{
    
    //        Text field for player name
    let stepsTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    
    override func didMove(to view: SKView) {
        
        let titleLabel = SKLabelNode()
        titleLabel.text = "Bubble Pop"
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontSize = 190
        titleLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.75)
        titleLabel.fontColor = SKColor.white
        titleLabel.zPosition = 1
        self.addChild(titleLabel)
        
        //        Text field for player name
        stepsTextField.placeholder = "Enter name here"
        stepsTextField.center = (self.view?.center)!
        stepsTextField.font = UIFont.systemFont(ofSize: 15)
        stepsTextField.borderStyle = UITextBorderStyle.roundedRect
        stepsTextField.autocorrectionType = UITextAutocorrectionType.no
        stepsTextField.keyboardType = UIKeyboardType.default
        stepsTextField.returnKeyType = UIReturnKeyType.done
        stepsTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        stepsTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
//        stepsTextField.value(forKey: "playerName")
        self.view?.addSubview(stepsTextField)
        
        // Close keyboard
        stepsTextField.delegate = self as? UITextFieldDelegate
//        not hidden text box
        stepsTextField.isHidden = false
  
        let startLabel = SKLabelNode()
        startLabel.text = "Start game!"
        startLabel.fontName = "AvenirNext-Bold"
        startLabel.fontSize = 100
        startLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.30)
        startLabel.fontColor = SKColor.white
        startLabel.zPosition = 1
        startLabel.name = "startButton"
        self.addChild(startLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            //            identify touch object or not
            let touchPosition = touch.location(in: self)
            let tappedObject = atPoint(touchPosition)
            let tappedObjectName = tappedObject.name
            
            if tappedObjectName == "startButton"{
                let moveToGameScene = GameScene(size: self.size)
                moveToGameScene.scaleMode = self.scaleMode
                self.run(clickSound)
                let transScene = SKTransition.fade(withDuration: 0.5)
//                playerName = "\(stepsTextField)"
                playerName = "\(stepsTextField.text!)"
                stepsTextField.isHidden = true
                self.view!.presentScene(moveToGameScene, transition: transScene)
            }
            
        }
    }

    
    
}
