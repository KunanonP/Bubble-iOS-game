//
//  GameViewController.swift
//  bubblepop2
//
//  Created by Kunanon Pititheerachot on 5/5/18.
//  Copyright © 2018 Kunanon Pititheerachot. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//var playerName = nameText.text!

class GameViewController: UIViewController {
//    @IBOutlet weak var nameText: UITextField!
    
//    let name = nameText.text!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
      
        let scene = MainScene(size: CGSize(width: 1536, height:2048))
            // Get the SKScene from the loaded GKScene
//            if let sceneNode = scene.rootNode as! GameScene? {
        
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
        
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
        
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(scene)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = false
                    view.showsNodeCount = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
