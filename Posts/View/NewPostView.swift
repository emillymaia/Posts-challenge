//
//  NewPostView.swift
//  Posts
//
//  Created by Emilly Maia on 10/08/22.
//

import SwiftUI

struct NewPostView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var content: String
    @State var isAlert = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment:.leading) {
                    Text("Create new Post")
                        .font(Font.system(size: 16, weight: .bold))
                    
                    //   TextField ("Title", text: $title)
                    //                        .padding()
                    //                        .background(Color.white)
                    //                        .cornerRadius(6)
                    //                        .padding(.bottom)
                    
                    TextField ("Write Something", text: $content)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Spacer()
                    
                }.padding()
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("No data")
                        let message = Text("please fill you post")
                        return Alert(title: title, message: message)
                    })
            }
            .navigationBarTitle("New Post", displayMode: .inline )
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
    
    var leading: some View{
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Cancel")
        })
    }
    
    var trailing: some View{
        Button(action: {
            if /*title != "" &&*/ content != "" {
                let parameters: [String: Any] = [/*"title": title*/ "content": content]
                viewModel.createPost(parameters: parameters)
                
                viewModel.fetchPosts()
                
                
                isPresented.toggle()
            } else {
                isAlert.toggle()
            }
            
        }, label: {
            Text("Post")
        })
    }
}

//struct NewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostView()
//    }
//}
