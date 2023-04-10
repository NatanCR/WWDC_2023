//
//  FinalScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 10/04/23.
//

import SpriteKit

class FinalScene: SKScene {
    private let screenHeight = UIScreen.main.bounds.height
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        self.addChild(createFinalMessage())
    }
    
    func createFinalMessage() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "originalStory")
        let node = SKSpriteNode(texture: texture)
        if screenHeight >= CGFloat.iphoneSELandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            node.setScale(1)
        } else if screenHeight >= CGFloat.ipad10LandscapeHeight && screenHeight <= CGFloat.ipadPro12LandscapeHeight {
            node.setScale(0.8)
        }
        
        node.position = CGPoint(x: 0, y: 0)
        node.zPosition = 1
        return node 
    }
    
    func finishButton() -> GameButton {
        let button = GameButton(texture: "buttonFinish", pointPosition: CGPoint())
        button.setAction(action: .endMoved) { touches in
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let startScene = StartScene(size: .defaultSceneSize)
            self.view?.presentScene(startScene, transition: transition)
        }
        
        if screenHeight >= CGFloat.iphone12LandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            button.setScale(1.3)
            button.position = .goButtonIphonePosition
        } else if screenHeight <= CGFloat.ipadPro11LandscapeHeight && screenHeight >= CGFloat.ipad10LandscapeHeight {
            button.setScale(1)
            button.position = .goButtonIpadPosition
        } else if screenHeight == CGFloat.ipadPro12LandscapeHeight {
            button.setScale(1)
            button.position = .goButtonIpadPosition
        }
        
        return button
    }
}
