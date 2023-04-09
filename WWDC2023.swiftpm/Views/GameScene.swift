//
//  GameScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 22/03/23.
//

import SpriteKit

struct ButtonTextures {
    static let btnActiveTextures = ["startButton", "middleButton", "endButton"]
    static let btnNoActiveTextures = ["startButtonGray", "middleButtonGray", "endButtonGray"]
}

struct StoryTextures {
    static let storyTextures = ["startStory", "middleStory", "endStory"]
}

struct StoryChoice {
    let story: String
    let part: String
}

class GameScene: SKScene {
    private let screenHeight = UIScreen.main.bounds.height
    private var shuffleTextures = StoryTextures.storyTextures.shuffled()
    private var buttonSequence = [String]()
    private var storyChoices: [StoryChoice] = []
//    private var sortedStoryChoices: [StoryChoice] = []
    private var storyNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.scaleMode = .aspectFill
        backgroundColor = UIColor(named: "background") ?? UIColor(red: 0.50, green: 0.71, blue: 0.89, alpha: 1.00)
        setUpScene()
        storyNode = createStoryNode()
        self.addChild(storyNode)
        print(shuffleTextures)
    }
    
    func sortStruct() {
        let sortedStoryChoices = storyChoices.sorted(by: {$0.part < $1.part})
        storyChoices = sortedStoryChoices
        print("ORDENADO - \(storyChoices)")
    }
    
    func setUpScene() {
        self.addChild(tableCreate())
        self.addChild(goButton())
        self.addChild(startButton())
        self.addChild(middleButton())
        self.addChild(endButton())
    }
    
    func createStoryNode() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: shuffleTextures.first ?? "")
        let node = SKSpriteNode(texture: texture)
        node.name = "\(shuffleTextures.first!)"
        node.size = texture.size()
        node.position = .storysIphonePosition
        node.zPosition = 1
        node.setScale(1)
        return node
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
    
    func goButton() -> GameButton {
        let button = GameButton(texture: "middleCloud", pointPosition: CGPoint())
        button.setAction(action: .endMoved) { touches in
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let startScene = StartScene(size: .defaultSceneSize)
            self.view?.presentScene(startScene, transition: transition)
        }
                
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
    
    func startButton() -> GameButton {
        let button = GameButton(texture: ButtonTextures.btnActiveTextures[0], pointPosition: .startButtonIphoneIpad)
        button.setScale(1)
        button.name = "button-0"
        button.setAction(action: .endMoved) { [self] touches in
            button.run(SKAction.setTexture(SKTexture(imageNamed: ButtonTextures.btnNoActiveTextures[0])))
            button.isUserInteractionEnabled = false
            buttonSequence.append(button.name!)

            if storyNode.name == shuffleTextures.first {
                storyChoices.append(StoryChoice(story: shuffleTextures.first ?? "", part: button.name ?? "button-0"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[1])
                storyNode.name = shuffleTextures[1]
                
            } else if storyNode.name == shuffleTextures[1] {
                storyChoices.append(StoryChoice(story: shuffleTextures[1], part: button.name ?? "button-0"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[2])
                storyNode.name = shuffleTextures[2]
                
            } else if storyNode.name == shuffleTextures[2] {
                storyChoices.append(StoryChoice(story: shuffleTextures[2], part: button.name ?? "button-0"))
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let resultScene = ResultScene(sortedStoryChoice: storyChoices)
                self.view?.presentScene(resultScene, transition: transition)
                sortStruct()
            }
        }
        return button
    }
    
    func middleButton() -> GameButton {
        let button = GameButton(texture: ButtonTextures.btnActiveTextures[1], pointPosition: .middleButtonIphoneIpad)
        button.setScale(1)
        button.name = "button-1"
        button.setAction(action: .endMoved) { [self] touches in
            button.run(SKAction.setTexture(SKTexture(imageNamed: ButtonTextures.btnNoActiveTextures[1])))
            button.isUserInteractionEnabled = false
            buttonSequence.append(button.name!)
            
            if storyNode.name == shuffleTextures.first {
                storyChoices.append(StoryChoice(story: shuffleTextures.first ?? "", part: button.name ?? "button-1"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[1])
                storyNode.name = shuffleTextures[1]
                
            } else if storyNode.name == shuffleTextures[1] {
                storyChoices.append(StoryChoice(story: shuffleTextures[1], part: button.name ?? "button-1"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[2])
                storyNode.name = shuffleTextures[2]
                
            } else if storyNode.name == shuffleTextures[2] {
                storyChoices.append(StoryChoice(story: shuffleTextures[2], part: button.name ?? "button-1"))
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let resultScene = ResultScene(sortedStoryChoice: storyChoices)
                self.view?.presentScene(resultScene, transition: transition)
                sortStruct()
            }
        }
        return button
    }
    
    func endButton() -> GameButton {
        let button = GameButton(texture: ButtonTextures.btnActiveTextures[2], pointPosition: .endButtonIphoneIpad)
        button.setScale(1)
        button.name = "button-2"
        button.setAction(action: .endMoved) { [self] touches in
            button.run(SKAction.setTexture(SKTexture(imageNamed: ButtonTextures.btnNoActiveTextures[2])))
            button.isUserInteractionEnabled = false
            buttonSequence.append(button.name!)

            if storyNode.name == shuffleTextures.first {
                storyChoices.append(StoryChoice(story: shuffleTextures.first ?? "", part: button.name ?? "button-2"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[1])
                storyNode.name = shuffleTextures[1]
                
            } else if storyNode.name == shuffleTextures[1] {
                storyChoices.append(StoryChoice(story: shuffleTextures[1], part: button.name ?? "button-2"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[2])
                storyNode.name = shuffleTextures[2]
                
            } else if storyNode.name == shuffleTextures[2] {
                storyChoices.append(StoryChoice(story: shuffleTextures[2], part: button.name ?? "button-2"))
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let resultScene = ResultScene(sortedStoryChoice: storyChoices)
                self.view?.presentScene(resultScene, transition: transition)
                sortStruct()
            }
        }
        return button
    }
}
