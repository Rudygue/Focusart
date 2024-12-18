//
//  Arc.swift
//  timer 23
//
//  Created by Rita Guerriero on 11/12/24.
//

import SwiftUI

struct Arc: Shape, Animatable {
    var filled: Double
    var radius: Double
    
    var animatableData: Double {
        get { filled }
        set { filled = newValue }
    }
    
    init(filled: Double, radius: Double) {
        self.filled = filled
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: .degrees(360*filled-90),
            endAngle: .degrees(-90),
            clockwise: true
        )
        
        return path
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        CGSize(width: 2*radius, height: 2*radius)
    }
}

#Preview {
    @Previewable @State var filled = 0.0
    
    ScrollView {
        Arc(filled: filled, radius: 150)
            .stroke(.linearGradient(colors: [.blue, .cyan, .indigo], startPoint: .leading, endPoint: .trailing), lineWidth: 10)
            .padding()
            .overlay {
                Button("Add") {
                    withAnimation {
                        filled += 0.1
                    }
                }
            }
    }
}
