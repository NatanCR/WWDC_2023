//
//  ResultScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 09/04/23.
//

import SpriteKit

struct ResultPosition {
    static let iphonePositions = [CGPoint(x: -450, y: 280),CGPoint(x: -450, y: 0),CGPoint(x: -450, y: -280)]
    static let ipadPositions = [CGPoint(x: -400, y: 280),CGPoint(x: -400, y: 0),CGPoint(x: -400, y: -280)]
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
        self.addChild(createResultMessage())
        self.addChild(goButton())
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
    }
    
    func goButton() -> GameButton {
        let button = GameButton(texture: "buttonNext", pointPosition: CGPoint())
        button.setAction(action: .endMoved) { touches in
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let finalScene = FinalScene(size: .defaultSceneSize)
            self.view?.presentScene(finalScene, transition: transition)
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
    
    func createResultMessage() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "resultMessage")
        let node = SKSpriteNode(texture: texture)
        
        if screenHeight >= CGFloat.iphone12LandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            node.setScale(0.9)
            node.position = CGPoint(x: 300, y: 0)
        } else if screenHeight >= CGFloat.ipad10LandscapeHeight && screenHeight <= CGFloat.ipadPro11LandscapeHeight {
            node.setScale(0.9)
            node.position = CGPoint(x: 300, y: -100)
        } else if screenHeight >= CGFloat.ipadPro12LandscapeHeight {
            node.setScale(0.85)
            node.position = CGPoint(x: 300, y: -80)
        }
        
        
        node.zPosition = 0
        
        return node
    }
    
    func createTextureSequence() {
        for i in sortedStoryChoice {
            storyTextureArray.append(i.story)
        }
        print("PRINT DA ARRAY DE TEXTURAS TELA DE RESULTADO \(storyTextureArray)")
    }
    
    private func definedDevicePosition() -> [CGPoint] {
            var positionArray = [CGPoint]()
            if screenHeight >= CGFloat.iphoneSELandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
                positionArray = ResultPosition.iphonePositions
            } else if screenHeight >= CGFloat.ipad10LandscapeHeight && screenHeight <= CGFloat.ipadPro12LandscapeHeight {
                positionArray = ResultPosition.ipadPositions
            }
            return positionArray
        }
    
    func createStoryNodes() {
        createTextureSequence()
        for i in 0..<storyTextureArray.count {
            let obj = GameButton(texture: storyTextureArray[i], pointPosition: definedDevicePosition()[i])
            obj.setScale(0.6)
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
