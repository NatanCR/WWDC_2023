//
//  Button.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 22/03/23.
//

import SpriteKit

class Button: SKNode {
    var image: SKSpriteNode?
    var actionBegan: (() -> Void)?
    var actionEnded: (() -> Void)?
    
    init(image: SKSpriteNode, actionBegan: @escaping () -> Void, actionEnded: @escaping () -> Void) {
        self.image = image
        self.actionBegan = actionBegan
        self.actionEnded = actionEnded
        super.init()
        //pode receber interação com o usuário
        self.isUserInteractionEnabled = true
        self.image?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            buttonPressed()
            self.actionBegan?()
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.actionEnded?()
        }
        
//        public func buttonPressed() {
//            let sequenceAnim = SKAction.sequence([
//                ButtonAnimation.pressed()])
//            self.run(sequenceAnim)
//        }
}
