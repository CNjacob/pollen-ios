//
//  InputItem.swift
//  Pollen
//
//  Created by user on 2020/11/26.
//

import SwiftUI

struct InputItem: View {
    enum FieldType {
        case text
        case secure
    }
    
    let iconImageName: String
    let title: String
    let input: Binding<String>
    let type: FieldType
    
    var body: some View {
        VStack {
            
            HStack {
                
                Image(iconImageName)
                    .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)
                
                switch type {
                case .text:
                    TextField(title, text: input)
                        .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                        .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                        .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                        .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)                        
                    
                case .secure:
                    SecureField(title, text: input)
                        .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                        .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                        .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                        .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                }
            }
            
            Seperator()
        }
    }
}
