//
//  PrivacyPolicyView.swift
//  Pollen
//
//  Created by user on 2020/12/18.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    var body: some View {
        VStack {
            Text("    花粉圈App深知用户个人信息隐私对于用户的重要性，花粉圈会尽全力保护用户的个人信息安全可靠。根据法律法规、国家标准等规定，制定以下《花粉圈隐私政策》（以下简称本政策或本隐私政策）\n")
                .padding(.top)
            
            Text("    花粉圈不会获取用户手机上的隐私信息，它仅仅是一个生活工具存在。\n")
            
            Text("    请在使用花粉圈的产品和服务前，仔细阅读并充分了解本隐私政策内容。一旦您开始使用我们的产品或服务，即表示您已充分理解并同意本政策。\n")
            
            Text("    最后住您使用得开心，也希望花粉圈能给您带来便捷～～～\n\n\n")
            
            HStack {
                Spacer()
                
                Text("生效日期： 2020 年 12 月 18 日")
                    .frame(alignment: .trailing)
                    .padding(.trailing)
            }
            
            Spacer()
        }
        .navigationBarTitle("《花粉圈App》隐私政策", displayMode: .inline)
    }
}
