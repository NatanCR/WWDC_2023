import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        // create a sprite variable scene
        let scene = StartScene(size: .defaultSceneSize)
        scene.scaleMode = .aspectFill
        return scene
    }
    var body: some View {
        // call the sprite scene view 
        SpriteView(scene: scene)
            .statusBarHidden()
            .ignoresSafeArea()
    }
}
