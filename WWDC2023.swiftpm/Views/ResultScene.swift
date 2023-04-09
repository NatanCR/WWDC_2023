//
//  ResultScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 09/04/23.
//

import SpriteKit

struct ResultPosition {
    static let positions = [CGPoint(x: -300, y: 300),CGPoint(x: 300, y: 0),CGPoint(x: -300, y: -300)]
}

class ResultScene: SKScene {
    private let screenHeight = UIScreen.main.bounds.height
    private var deltaTime: TimeInterval = 0
    private var lastFrameTime: TimeInterval = 0
    private var bg = SKSpriteNode()
    private var proxBg = SKSpriteNode()
    private var sortedStoryChoice: [StoryChoice]
    private var storyTextureArray: [String] = []
    private var storysSprites: [GameButton] = []
    
    init(sortedStoryChoice: [StoryChoice]) {
        self.sortedStoryChoice = sortedStoryChoice
        super.init(size: .defaultSceneSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        createStoryNodes()
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
    }
    
    func createTextureSequence() {
        for i in sortedStoryChoice {
            storyTextureArray.append(i.story)
        }
        print("PRINT DA ARRAY DE TEXTURAS TELA DE RESULTADO \(storyTextureArray)")
    }
    
    func createStoryNodes() {
        createTextureSequence()
        for i in 0..<storyTextureArray.count {
            let obj = GameButton(texture: storyTextureArray[i], pointPosition: ResultPosition.positions[i])
            storysSprites.append(obj)
            self.addChild(storysSprites[i])
        }
    }
    
    func backgroundCreate() -> SKSpriteNode {
        let backgroundTexture = SKTexture(imageNamed: "cloudInfinit")
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        backgroundNode.setScale(1)
        backgroundNode.zPosition = -1
        return backgroundNode
    }
    
    func moveSprite(sprite : SKSpriteNode,nextSprite : SKSpriteNode, speed : Float) -> Void {
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
