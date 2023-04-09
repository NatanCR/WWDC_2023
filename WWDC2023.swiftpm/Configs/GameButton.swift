//
//  GameButton.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 03/04/23.
//

import SpriteKit

class GameButton: SKSpriteNode {
    private var actionBegan: ((_ touches: Set<UITouch>)-> Void)?
    private var actionEnded: ((_ touches: Set<UITouch>)-> Void)?
    private var pointPosition: CGPoint
    
    enum ActionType{
        case endMoved,touch
    }
    
    init(texture: String, pointPosition: CGPoint) {
        self.pointPosition = pointPosition
        let texture = SKTexture(imageNamed: texture)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.isUserInteractionEnabled = true
        self.zPosition = 1
        self.position = pointPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAction(action type: ActionType,_ action: @escaping (_ touches: Set<UITouch>)-> Void){
        switch type {
        case .endMoved:
            self.actionEnded = action
        case .touch:
            self.actionBegan = action
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.actionBegan?(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.actionEnded?(touches)
    }
}
