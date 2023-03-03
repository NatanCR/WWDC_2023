import SwiftUI

struct ContentView: View {
    //    @State private var orientation = UIDeviceOrientation.unknown
    @State private var isAnimate : Bool = false
    let secondaryAccentColor = Color("SecundaryAccentColor")
    let accentColor = Color("AccentColor")
    
    var body: some View {
            VStack() {
                NavigationLink(
                    destination: HistoryCard(),
                    label: {
                        Text("Start")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(isAnimate ? secondaryAccentColor : accentColor)
                            .cornerRadius(20)
                    })
                .padding(.horizontal, isAnimate ? 30 : 50)
                .shadow(color: isAnimate ? secondaryAccentColor.opacity(0.7) : accentColor.opacity(0.7),
                        radius: isAnimate ? 30 : 10,
                        x: 0,
                        y: isAnimate ? 50 : 30 )
                .scaleEffect(isAnimate ? 1.1 : 1.0)
                .offset(y: isAnimate ? -7 : 0)
                .onAppear(perform: addAnimation)
            }
            .padding(40)
            .frame(maxWidth: 500, maxHeight: .infinity)
            //        .onRotate { newOrientation in
            //                    orientation = newOrientation
            //                }
    }
    
    func addAnimation() {
        guard !isAnimate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                isAnimate.toggle()
            }
        }
    }
    
}

//struct DeviceRotationViewModifier: ViewModifier {
//    let action: (UIDeviceOrientation) -> Void
//
//    func body(content: Content) -> some View {
//        content
//            .onAppear()
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//                action(UIDevice.current.orientation)
//            }
//    }
//}

// A View wrapper to make the modifier easier to use
//extension View {
//    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
//        self.modifier(DeviceRotationViewModifier(action: action))
//    }
//}
