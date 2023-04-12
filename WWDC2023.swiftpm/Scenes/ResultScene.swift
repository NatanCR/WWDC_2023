//
//  ResultScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 09/04/23.
//

import SpriteKit

// MARK: - Struct of positions arrays to create storys node
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
    private var sortedStoryChoice: [StoryChoice] // array of the choices struct
    private var storyTextureArray: [String] = [] // textures array of the choices
    private var storysSprites: [GameButton] = [] // array of the choices button
    
    // MARK: - init to get the sorted story choices for show in this scene
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
    
    // MARK: - Makes a button to go to the final scene 
    func goButton() -> GameButton {
        // Create a node using the class GameButton
        let button = GameButton(texture: "buttonNext", pointPosition: CGPoint())
        button.setAction(action: .endMoved) { touches in
            // Call the other scene
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let finalScene = FinalScene(size: .defaultSceneSize)
            self.view?.presentScene(finalScene, transition: transition)
        }
        
        // Identify which device is running to set the scale node and the position node
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
    
    // MARK: - Makes the result message node
    func createResultMessage() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "resultMessage")
        let node = SKSpriteNode(texture: texture)
        
        // Identify which device is running to set the scale node and the position node
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
    
    // MARK: - Use the sorted story choice array to fill the texture array, for after use that to create textures nodes
    func createTextureSequence() {
        for i in sortedStoryChoice {
            storyTextureArray.append(i.story)
        }
    }
    
    // MARK: - Identify which device is running to set the position node
    private func definedDevicePosition() -> [CGPoint] {
            var positionArray = [CGPoint]()
            if screenHeight >= CGFloat.iphoneSELandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
                positionArray = ResultPosition.iphonePositions
            } else if screenHeight >= CGFloat.ipad10LandscapeHeight && screenHeight <= CGFloat.ipadPro12LandscapeHeight {
                positionArray = ResultPosition.ipadPositions
            }
            return positionArray
        }
    
    // MARK: - Makes the user story nodes sequence and add on the scene
    func createStoryNodes() {
        createTextureSequence()
        for i in 0..<storyTextureArray.count {
            // I used the Game Button class because is the same struct to create another node
            let obj = GameButton(texture: storyTextureArray[i], pointPosition: definedDevicePosition()[i])
            obj.setScale(0.6)
            storysSprites.append(obj)
            self.addChild(storysSprites[i])
        }
    }
    
    // MARK: - Make background cloud to screen
    func backgroundCreate() -> SKSpriteNode {
        let backgroundTexture = SKTexture(imageNamed: "cloudInfinit")
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        backgroundNode.setScale(1)
        backgroundNode.zPosition = -1
        return backgroundNode
    }
    
    // MARK: - Makes the cloud move
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

    // MARK: - Makes the time are updating
    override func update(_ currentTime: TimeInterval) {
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        deltaTime = currentTime - lastFrameTime
        lastFrameTime = currentTime
        self.moveSprite(sprite: bg, nextSprite: proxBg, speed: 50)
    }
}
