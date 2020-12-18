//
//  View++.swift
//  Pollen
//
//  Created by user on 2020/12/3.
//

import SwiftUI

extension View {
    func lefting() -> some View {
        HStack {
            self
            Spacer()
        }
    }
    
    func righting() -> some View {
        HStack {
            Spacer()
            self
        }
    }
    
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}


struct ListSeparatorStyle: ViewModifier {
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}
