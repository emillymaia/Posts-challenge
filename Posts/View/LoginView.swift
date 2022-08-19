//
//  RegisterUserView.swift
//  Posts
//
//  Created by Emilly Maia on 17/08/22.
//

import SwiftUI

let lightGreycolor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView: View {
 
    @StateObject private var loginVM = LoginViewModel()
    @State private var isActive = false

    var body: some View {
        NavigationView{
            
                VStack{
                    WelcomeText()
                    UserImage()
                    TextField("Email", text: $loginVM.email)
                        .padding()
                        .background(lightGreycolor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    TextField("Password", text: $loginVM.password)
                        .padding()
                        .background(lightGreycolor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                
                        
                    Button {
                        //a loginVM.login só permite que o usuário acesse a página posts se o @escaping retornar true!
                        loginVM.login { result, error in
                            if result {
                                isActive = true
                            }
                        }
                    } label: {
                        LoginButtonContent()
                    }
                    //direciona pra página de posts
                    NavigationLink(destination: ContentView().environmentObject(ViewModel()), isActive: $isActive) { }
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("registre-se").foregroundColor(.pink)
                    }
                    
                }
                .padding()
        }
        .navigationViewStyle(.stack)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
//estilizando texto de bem-vindo
struct WelcomeText: View {
    var body: some View {
        VStack{
            Text("Bem-vindo!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
        }
    }
}
//estilizando imagem (mocada)
struct UserImage: View {
    var body: some View {
        VStack{
            return Image("userImage")
                .resizable()
                .aspectRatio(UIImage(named: "userImage")!.size, contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom, 75)
        }
    }
}

//estilizando botao login
struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundStyle(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.pink)
            .cornerRadius(25.0)
    }
}
