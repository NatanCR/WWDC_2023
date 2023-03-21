//
//  StartScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 17/03/23.
//

import SpriteKit

class StartScene: SKScene {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        setUpScene()
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
    
    func setUpScene() {
        self.addChild(groundCreate())
        self.addChild(tableCloudCreate())
        self.addChild(startButtonCreate())
    }
    
    func groundCreate() -> SKSpriteNode {
        let groundTexture = SKTexture(imageNamed: "cloud")
        let groundNode = SKSpriteNode(texture: groundTexture)
        groundNode.setScale(1.3)
        groundNode.zPosition = -1
        return groundNode
    }
    
    func tableCloudCreate() -> SKSpriteNode {
        let tcTexture = SKTexture(imageNamed: "tableCloud")
        let tcNode = SKSpriteNode(texture: tcTexture)
        tcNode.setScale(1)
        tcNode.zPosition = 0
        return tcNode
    }
    
    func startButtonCreate() -> SKSpriteNode {
        let btnTexture = SKTexture(imageNamed: "cloudButton")
        let btnNode = SKSpriteNode(texture: btnTexture)
        btnNode.setScale(1)
        btnNode.zPosition = 1
        return btnNode
    }
}
