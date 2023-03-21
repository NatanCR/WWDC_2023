import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = StartScene(size: .defaultSceneSize)
        scene.scaleMode = .aspectFill
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
            .statusBarHidden()
            .ignoresSafeArea()
    }
}
