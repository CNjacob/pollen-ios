//
//  MineRow.swift
//  Pollen
//
//  Created by user on 2020/12/4.
//

import SwiftUI

struct MineRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(icon)
                
                Text(title)
                    .font(.system(size: 16))
                
                Spacer()
                
                Image("cell_detail_indicator")
            }
            .padding()
        }
        .frame(height: 54)
    }
}
