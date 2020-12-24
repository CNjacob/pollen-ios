//
//  LoginView.swift
//  Pollen
//
//  Created by user on 2020/11/20.
//

import SwiftUI
import Alamofire

struct LoginView: View {
    @EnvironmentObject var store: Store
    
    private var login: AppState.AccountState { store.appState.account }
    private var loginBinding: Binding<AppState.AccountState> { $store.appState.account }
        
    var alert: Alert {
        Alert(title: Text("温馨提示"), message: Text(login.loginErrorMessage), dismissButton: .default(Text("好的")))
    }
    
    var closeButton: some View {
        Button(action: {
            store.dispatch(.dismissLoginView)
        }) {
            Image("close_button")
                .accessibility(label: Text("关闭"))
                .padding(5)
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Image("loginLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(150)
                    .padding(.bottom, 40)
                
                
                InputItem(iconImageName: "icon_user", title: "用户名", input: loginBinding.checker.loginUsername, type: .text)
                
                InputItem(iconImageName: "icon_password", title: "密码", input: loginBinding.checker.loginPassword, type: .secure)
                
                /*
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()

                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("忘记密码?")
                                .foregroundColor(Color("textColor"))
                                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))
                        }
                    }.padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                } */
                
                VStack {
                    Spacer()
                    
                    ColorButton(
                        btnText: "登录",
                        textColor: (login.loginValid ? Color("textColor") : Color("greyTextColor")),
                        backgroundColor: (login.loginValid ? Color("lightblueColor") : Color("lightGreyColor")),
                        disabled: !login.loginValid
                    ) {
                        store.dispatch(
                            .login(
                                username: login.checker.loginUsername,
                                password: login.checker.loginPassword
                            )
                        )
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Spacer(minLength: 10)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("没有账号? 注册账号")
                            .foregroundColor(Color("textColor"))
                            .font(.system(size: 15, weight: .bold, design: .default))
                    }
                    
                    Spacer(minLength: 20)
                }
            }
            .overlay(Group {
                if login.loginRequesting {
                    ActivityIndicator(style: .large)
                } else {
                    EmptyView()
                }
            })
            .alert(isPresented: loginBinding.loginFailure, content: { self.alert })
            .navigationBarItems(trailing: closeButton)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
