//
//  GameScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 22/03/23.
//

import SpriteKit

class GameScene: SKScene {
    let widthScreen = UIScreen.main.bounds.size.width
    let heightScreen = UIScreen.main.bounds.size.height
    
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
//        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        self.addChild(tableCreate())
        self.addChild(goButton())
    }
    
    func tableCreate() -> SKSpriteNode {
        let tbTexture = SKTexture(imageNamed: "compTableCloud")
        let tbNode = SKSpriteNode(texture: tbTexture)
        tbNode.setScale(0.9)
        tbNode.zPosition = 0
        tbNode.position = CGPoint(x: widthScreen*0.3, y: heightScreen*0.3)
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
        button.setScale(1)
        button.zPosition = 1
        button.position = CGPoint(x: widthScreen*0.5, y: heightScreen*0.6)
        return button
    }
}
