//
//  RegisterView.swift
//  Posts
//
//  Created by Emilly Maia on 16/08/22.
//

import SwiftUI
import Foundation

struct UserModel: Encodable {
    var id: String
    var name: String
    var email: String
}

struct UserCreate: Codable {
    let name: String
    let email: String
    let password: String
}

struct RegisterView: View {
    @State var createUsername: String = ""
    @State var createPassword: String = ""
    @State var email: String = ""
    var body: some View {
        VStack{
            TextField("Insira nome de usuário", text: $createUsername)
                .padding()
                .background(lightGreycolor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField("Insira seu e-mail", text: $email)
                .padding()
                .background(lightGreycolor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Crie uma senha", text: $createPassword)
                .padding()
                .background(lightGreycolor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button(action: {
                Task {
                    do {
                        try await WebService().registerUser(nome: createUsername, email: email, password: createPassword)
                    } catch {
                        print(error)
                    }
                }
            }) {
                RegisterButtonContent()
            }
        }
        .padding()
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct RegisterButtonContent : View {
    var body: some View {
        return Text("Registrar")
            .font(.headline)
            .foregroundStyle(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.pink)
            .cornerRadius(25.0)
    }
}



