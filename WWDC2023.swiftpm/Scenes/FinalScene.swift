//
//  FinalScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 10/04/23.
//

import SpriteKit

class FinalScene: SKScene {
    private let screenHeight = UIScreen.main.bounds.height //get screen height
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        self.addChild(createFinalMessage())
        self.addChild(finishButton())
    }
    
    // MARK: - Makes the message node
    func createFinalMessage() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "originalStory")
        let node = SKSpriteNode(texture: texture)
        
        // Identify which device is running to set the scale node
        if screenHeight >= CGFloat.iphoneSELandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            node.setScale(0.9)
        } else {
            node.setScale(0.8)
        }
        
        node.position = CGPoint(x: 0, y: 0)
        node.zPosition = 1
        return node 
    }
    
    // MARK: - Makes a button to go to the start scene
    func finishButton() -> GameButton {
        // Create a node using the class GameButton
        let button = GameButton(texture: "buttonFinish", pointPosition: CGPoint())
        button.setAction(action: .endMoved) { touches in
            // call the start scene
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let startScene = StartScene(size: .defaultSceneSize)
            self.view?.presentScene(startScene, transition: transition)
        }
        
        // Identify which device is running to set the scale node and the position node
        if screenHeight >= CGFloat.iphone12LandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            button.setScale(1.3)
            button.position = .goButtonIphonePosition
        } else {
            button.setScale(1)
            button.position = .goButtonIpadPosition
        }
        
        return button
    }
}
