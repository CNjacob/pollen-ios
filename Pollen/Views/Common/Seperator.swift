//
//  Seperator.swift
//  Pollen
//
//  Created by user on 2020/11/26.
//

import SwiftUI

struct Seperator: View {
    var body: some View {
        VStack {
            Divider().background(Color("lightGreyColor"))
        }
        .padding()
        .frame(height: 1, alignment: .center)
    }
}

struct Seperator_Previews: PreviewProvider {
    static var previews: some View {
        Seperator()
    }
}
