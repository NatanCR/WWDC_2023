//
//  HistoryCard.swift
//  WWDC2023
//
//  Created by Natan de Camargo Rodrigues on 01/03/23.
//

import SwiftUI

struct HistoryCard: View {
    
    private let accentColor = Color("AccentColor")
    @State var isAnimate = false
    
    var body: some View {
        VStack {
            Button("Scale Transition") {
                withAnimation(.spring()) {
                    self.isAnimate.toggle()
                }
            }
            Spacer()
            if isAnimate {
            ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .foregroundColor(accentColor)
                        .padding()
                    VStack {
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular, design: .serif))
                    }
                    .padding(.horizontal, 30)
                    
                    
                    //            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                    //                .multilineTextAlignment(.leading)
                    //                .foregroundColor(.white)
                    //                .font(.system(size: 15, weight: .regular, design: .serif))
                    //                .padding()
                    //                .frame(maxHeight: 160)
                    //                .frame(maxWidth: .infinity)
                    //                .background(accentColor)
                    //                .cornerRadius(20)
                    //                .padding(.vertical, 120)
                    //                .padding(.horizontal, 30)
                }
            .transition(.scale(scale: 0.5, anchor: UnitPoint(x: 0.5, y: -1)))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .foregroundColor(accentColor)
                        .padding()
                    VStack {
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular, design: .serif))
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .padding()
    }
    
    struct HistoryCard_Previews: PreviewProvider {
        static var previews: some View {
            HistoryCard()
        }
    }
}
