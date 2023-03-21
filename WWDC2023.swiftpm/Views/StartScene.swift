//
//  StartScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 17/03/23.
//

import SpriteKit

class StartScene: SKScene {
    //    class func newScene() -> StartScene {
    //        let newScene = StartScene(size: .defaultSceneSize)
    //        newScene.scaleMode = .aspectFill
    //        return newScene
    //    }
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        //        self.size = .defaultSceneSize
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .blue
        //        self.scaleMode = .aspectFill
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
}
