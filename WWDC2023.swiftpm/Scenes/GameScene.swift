//
//  GameScene.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 22/03/23.
//

import SpriteKit

// MARK: - Struct of textures arrays to set the button-on and button-off
struct ButtonTextures {
    static let btnActiveTextures = ["startButton", "middleButton", "endButton"]
    static let btnNoActiveTextures = ["startButtonGray", "middleButtonGray", "endButtonGray"]
}

// MARK: - Struct of textures array to get the story assets
struct StoryTextures {
    static let storyTextures = ["startStory", "middleStory", "endStory"]
}

// MARK: - Struct for organize the user choices about story and the part
struct StoryChoice {
    let story: String
    let part: String
}

class GameScene: SKScene {
    private let screenHeight = UIScreen.main.bounds.height
    private var shuffleTextures = StoryTextures.storyTextures.shuffled() //shuffle the story textures to show on the scene
    private var buttonSequence = [String]() // sequence used by user
    private var storyChoices: [StoryChoice] = [] // story choice used by user
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
    }
    
    // MARK: - Sorted the story choices array by the part of story
    func sortStruct() {
        let sortedStoryChoices = storyChoices.sorted(by: {$0.part < $1.part})
        storyChoices = sortedStoryChoices
    }
    
    // MARK: - Set the functions on the scene
    func setUpScene() {
        self.addChild(tableCreate())
        self.addChild(startButton())
        self.addChild(middleButton())
        self.addChild(endButton())
    }
    
    // MARK: - Makes the story node by the first position of the textures array
    func createStoryNode() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: shuffleTextures.first ?? "")
        let node = SKSpriteNode(texture: texture)
        node.name = "\(shuffleTextures.first!)" // appointing the node name with the first position of the textures array
        node.size = texture.size()
        // Identify which device is running to set the position node
        if screenHeight >= CGFloat.iphoneSELandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            node.position = .storysIphonePosition
        } else if screenHeight >= CGFloat.ipad10LandscapeHeight && screenHeight <= CGFloat.ipadPro12LandscapeHeight {
            node.position = .storysIpadPostion
        }
        node.zPosition = 1
        node.setScale(1)
        return node
    }
    
    // MARK: - Makes the table draw node
    func tableCreate() -> SKSpriteNode {
        let tbTexture = SKTexture(imageNamed: "compTableCloud")
        let tbNode = SKSpriteNode(texture: tbTexture)
        tbNode.zPosition = 0
        // Identify which device is running to set the scale node and the position node
        if screenHeight >= CGFloat.iphone12LandscapeHeigth && screenHeight <= CGFloat.iphone12MaxLandscapeHeigth {
            tbNode.setScale(0.9)
            tbNode.position = CGPoint(x: self.size.width / 2.1, y: self.size.height / 3)
        } else if screenHeight <= CGFloat.ipadPro11LandscapeHeight && screenHeight >= CGFloat.ipad10LandscapeHeight {
            tbNode.setScale(0.9)
            tbNode.position = CGPoint(x: self.size.width / 2.05, y: self.size.height / 3.5)
        } else if screenHeight == CGFloat.ipadPro12LandscapeHeight {
            tbNode.setScale(0.8)
            tbNode.position = CGPoint(x: self.size.width / 2.1, y: self.size.height / 4)
        }
        return tbNode
    }
    
    // MARK: - Makes the start button
    func startButton() -> GameButton {
        // Create a node using the class GameButton
        let button = GameButton(texture: ButtonTextures.btnActiveTextures[0], pointPosition: .startButtonIpad)
        button.setScale(1)
        button.name = "button-0" // appointing the node name for use to organize the sequence
        button.setAction(action: .endMoved) { [self] touches in
            // change the button textures
            button.run(SKAction.setTexture(SKTexture(imageNamed: ButtonTextures.btnNoActiveTextures[0])))
            button.isUserInteractionEnabled = false
            buttonSequence.append(button.name!) // fill the button names array

            // verify which texture is presenting
            if storyNode.name == shuffleTextures.first {
                // fill the choices array
                storyChoices.append(StoryChoice(story: shuffleTextures.first ?? "", part: button.name ?? "button-0"))
                // and change the story texture
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[1])
                storyNode.name = shuffleTextures[1]
                
            } else if storyNode.name == shuffleTextures[1] {
                storyChoices.append(StoryChoice(story: shuffleTextures[1], part: button.name ?? "button-0"))
                storyNode.texture = SKTexture(imageNamed: shuffleTextures[2])
                storyNode.name = shuffleTextures[2]
                
            } else if storyNode.name == shuffleTextures[2] {
                storyChoices.append(StoryChoice(story: shuffleTextures[2], part: button.name ?? "button-0"))
                // when the last texture is present call the result scene
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let resultScene = ResultScene(sortedStoryChoice: storyChoices)
                self.view?.presentScene(resultScene, transition: transition)
                // sort the story choices array for show in the result scene
                sortStruct()
            }
        }
        return button
    }
    
    // MARK: - Makes the middle button
    func middleButton() -> GameButton {
        let button = GameButton(texture: ButtonTextures.btnActiveTextures[1], pointPosition: .middleButtonIpad)
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
    
    // MARK: - Makes the end button
    func endButton() -> GameButton {
        let button = GameButton(texture: ButtonTextures.btnActiveTextures[2], pointPosition: .endButtonIpad)
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
