//
//  CirclePart.swift
//  MemoryGame
//
//  Created by Michał Ziółek on 28/11/2023.
//

import SwiftUI
import CoreGraphics

struct CirclePart: Shape {
    var endAngle: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.move(to: center)

        path.addLine(to: CGPoint(
            x: center.x + radius * cos(0),
            y: center.y + radius * sin(0))
        )

        path.addArc(
            center: center,
            radius: radius,
            startAngle: Angle(radians: 0),
            endAngle: Angle(radians: Double(endAngle)),
            clockwise: false
        )

        path.addLine(to: center)

        return path
    }
}
struct CirclePartView: View {
    var body: some View {
        CirclePart(endAngle: CGFloat.pi * 1.25) // Example with 90 degrees
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .border(Color.gray)
            .rotationEffect(.degrees(-90))
    }
}

#Preview {
    CirclePartView()
}
