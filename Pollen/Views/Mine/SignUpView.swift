//
//  SignUpView.swift
//  Pollen
//
//  Created by user on 2020/11/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var store: Store
    
    private var signUp: AppState.AccountState { store.appState.account }
    private var signUpBinding: Binding<AppState.AccountState> { $store.appState.account }
        
    var body: some View {
        
        VStack {
            
            InputItem(iconImageName: "icon_user", title: "用户名", input: signUpBinding.checker.username, type: .text)
            
            InputItem(iconImageName: "icon_password", title: "密码", input: signUpBinding.checker.password, type: .secure)
            
            InputItem(iconImageName: "icon_password", title: "确认密码", input: signUpBinding.checker.verifyPassword, type: .secure)
            
            VStack {
                Spacer()
                
                ColorButton(
                    btnText: "注册",
                    textColor: (signUp.signUpValid ? Color("textColor") : Color("greyTextColor")),
                    backgroundColor: (signUp.signUpValid ? Color("lightblueColor") : Color("lightGreyColor")),
                    disabled: !signUp.signUpValid)
                {
                    store.dispatch(
                        .signUp(
                            username: signUp.checker.username,
                            password: signUp.checker.password
                        )
                    )
                }
                
                Spacer(minLength: 20)
                
                Text(signUp.warningMessage)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                
                Spacer()
            }
        }
        
        
        
        /*
        Form {
            Section(footer: Text(signUpViewModel.usernameMessage).foregroundColor(.red)) {
                InputItem(iconImageName: "icon_user", title: "用户名", input: $signUpViewModel.userName)
                    .autocapitalization(.none)
            }
            
            Section(footer: Text(signUpViewModel.passwordMessage).foregroundColor(.red)) {
                InputItem(iconImageName: "icon_password", title: "密码", input: $signUpViewModel.password)
            }
            
            Section(footer: Text(signUpViewModel.passwordMessage).foregroundColor(.red)) {
                InputItem(iconImageName: "icon_password", title: "密码", input: $signUpViewModel.confirmPassword)
            }
            
            Section {
                
                Button(action: {
                    self.signUp()
                }) {
                    Text("Sign up")
                }
                .disabled(!signUpViewModel.isValid)
            }
        } */
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
