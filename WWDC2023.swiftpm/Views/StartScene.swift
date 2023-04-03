//
//  StartScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 17/03/23.
//

import SpriteKit

class StartScene: SKScene {
    private let screenHeight = UIScreen.main.bounds.height
    private var deltaTime: TimeInterval = 0
    private var lastFrameTime: TimeInterval = 0
    private var bg = SKSpriteNode()
    private var proxBg = SKSpriteNode()
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        
        bg = backgroundCreate()
        proxBg = bg.copy() as! SKSpriteNode
        proxBg.position = CGPoint(x: bg.position.x + bg.size.width, y: bg.position.y)
        self.addChild(bg)
        self.addChild(proxBg)
        setUpScene()
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
    }
    
    func setUpScene() {
        self.addChild(tableCloudCreate())
        self.addChild(startButtonCreate())
    }
    
    func backgroundCreate() -> SKSpriteNode {
        let backgroundTexture = SKTexture(imageNamed: "cloudInfinit")
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        backgroundNode.setScale(1)
        backgroundNode.zPosition = -1
        return backgroundNode
    }
    
    
    func tableCloudCreate() -> SKSpriteNode {
        let tcTexture = SKTexture(imageNamed: "tableCloud")
        let tcNode = SKSpriteNode(texture: tcTexture)
        
        if screenHeight == CGFloat.ipadPro12LandscapeHeight {
            tcNode.setScale(0.9)
        } else {
            tcNode.setScale(1)
        }
        tcNode.zPosition = 0
        tcNode.position = CGPoint(x: 0, y: 0)
        return tcNode
    }
    
    func startButtonCreate() -> GameButton {
        let button = GameButton(texture: "cloudButton", pointPosition: CGPoint(x: 50, y: 50))
        button.setAction(action: .endMoved) { touches in
            let transition = SKTransition.fade(withDuration: 1)
            let gameScene = GameScene(size: .defaultSceneSize)
            self.view?.presentScene(gameScene)
        }
        
        if screenHeight == CGFloat.ipadPro12LandscapeHeight {
            button.setScale(0.9)
        } else {
            button.setScale(1)
        }
        return button
    }
    
    func moveSprite(sprite : SKSpriteNode,
                    nextSprite : SKSpriteNode, speed : Float) -> Void {
        var newPosition = CGPointZero
        for spriteToMove in [sprite, nextSprite] {
            newPosition = spriteToMove.position
            newPosition.x -= CGFloat(speed * Float(deltaTime))
            spriteToMove.position = newPosition
            
            if spriteToMove.frame.maxX < self.frame.minX {
                spriteToMove.position = CGPoint(x: spriteToMove.position.x + spriteToMove.size.width * 2, y: spriteToMove.position.y)
            }
        }
    }


    override func update(_ currentTime: TimeInterval) {
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        deltaTime = currentTime - lastFrameTime
        lastFrameTime = currentTime
        self.moveSprite(sprite: bg, nextSprite: proxBg, speed: 50)
    }
}
