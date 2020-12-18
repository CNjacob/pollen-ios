//
//  ColorButton.swift
//  Pollen
//
//  Created by user on 2020/11/26.
//

import SwiftUI

struct ColorButton: View {
    var btnText: String
    var textColor: Color
    var backgroundColor: Color
    var disabled: Bool?
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Text(btnText)
                    .font(.headline)
                    .foregroundColor(textColor)
                    .padding()
                    .frame(width: 140, height: 50)
                    .background(backgroundColor)
                    .clipped()
                    .cornerRadius(5.0)
                    .shadow(color: backgroundColor, radius: 5, x: 0, y: 5)
            }
        }
        .disabled(disabled ?? false)
    }
}
