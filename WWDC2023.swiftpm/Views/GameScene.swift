//
//  GameScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 22/03/23.
//

import SpriteKit

class GameScene: SKScene {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
//        box.position = location
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
//        addChild(box)
//    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.scaleMode = .aspectFill
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        self.addChild(tableCreate())
        self.addChild(goButton())
    }
    
    func tableCreate() -> SKSpriteNode {
        let tbTexture = SKTexture(imageNamed: "compTableCloud")
        let tbNode = SKSpriteNode(texture: tbTexture)
        tbNode.zPosition = 0
        
        if screenHeight >= CGFloat.iphone12LandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            tbNode.setScale(0.9)
            tbNode.position = CGPoint(x: self.size.width / 2.5, y: self.size.height / 3)
        } else if screenHeight <= CGFloat.ipadPro11LandscapeHeight && screenHeight >= CGFloat.ipad10LandscapeHeight {
            tbNode.setScale(0.9)
            tbNode.position = CGPoint(x: self.size.width / 2.05, y: self.size.height / 3.5)
        } else if screenHeight == CGFloat.ipadPro12LandscapeHeight {
            tbNode.setScale(0.8)
            tbNode.position = CGPoint(x: self.size.width / 2.1, y: self.size.height / 4)
        }
        return tbNode
    }
    
    func goButton() -> Button {
        let btnTexture = SKTexture(imageNamed: "middleCloud")
        let btnNode = SKSpriteNode(texture: btnTexture)
        let button = Button(image: btnNode) {
        } actionEnded: {
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let startScene = StartScene(size: .defaultSceneSize)
            self.view?.presentScene(startScene)
        }
        
        button.zPosition = 1
        
        if screenHeight >= CGFloat.iphone12LandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            button.setScale(1.3)
            button.position = CGPoint(x: self.size.width / 1.15, y: self.size.height / 4)
        } else if screenHeight <= CGFloat.ipadPro11LandscapeHeight && screenHeight >= CGFloat.ipad10LandscapeHeight {
            button.setScale(1)
            button.position = CGPoint(x: self.size.width / 1.2, y: self.size.height / 9)
        } else if screenHeight == CGFloat.ipadPro12LandscapeHeight {
            button.setScale(1)
            button.position = CGPoint(x: self.size.width / 1.25, y: self.size.height / 11)
        }
        return button
    }
}
