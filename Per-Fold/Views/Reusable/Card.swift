//
//  Card.swift
//  Per-Fold
//
//  Created by Aryan Verma on 15/06/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func card(color: Color, radius: CGFloat) -> some View {
        self.background(color)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .shadow(radius: 8)
    }
}
