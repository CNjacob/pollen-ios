//
//  ForgotPasswordView.swift
//  Pollen
//
//  Created by user on 2020/11/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State var username: String = ""
    @State var showAlert = false
    @State var alertMsg = ""

    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    Spacer(minLength: 80)
                    
                    Text("Write your email address in the text box and we will send you a verification code to reset your password.")
                        .font(.body)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)

                    InputItem(iconImageName: "icon_user", title: "用户名", input: $username, type: .text)
                    
                    Spacer(minLength: 20)
                    
                    ColorButton(btnText: "Submit", textColor: Color("textColor"), backgroundColor: Color("lightblueColor")) {
                        if self.isValidInputs() {
                            self.presentationMode.wrappedValue.dismiss()
                       
                        }
                    }
                }
            }
        }.alert(isPresented: $showAlert, content: { self.alert })
    }
    
    func isValidInputs() -> Bool {
        
        if self.username == "" {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
            
        } else if !self.username.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
}

struct ModalView: View {
    
  var body: some View {
    Group {
      Text("Modal view")
      
    }
  }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
