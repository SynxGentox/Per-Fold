//
//  Card.swift
//  Per-Fold
//
//  Created by Aryan Verma on 15/06/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func card(color: Color) -> some View {
        self.background(color)
            .clipShape(ConcentricRectangle(corners: .concentric(minimum: 28), isUniform: false))
            .shadow(radius: 8)
    }
}
