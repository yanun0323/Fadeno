//
//  LoadingCircle.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/1.
//

import SwiftUI

struct LoadingCircle: View {
    @State private var isLoading = false
    let color: Color
    let size: CGFloat
    let lineWidth: CGFloat
    let speed: Double
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.65)
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth))
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees:isLoading ? 360 : 0))
            .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: isLoading)
            .onAppear {
                isLoading = true
            }
    }
}

struct LoadingCircle_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCircle(color: .green, size: 12, lineWidth: 2, speed: 0.8)
    }
}
