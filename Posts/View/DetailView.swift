//
//  DetailView.swift
//  Posts
//
//  Created by Emilly Maia on 10/08/22.
//
//
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presetentionMode
    let item: PostModel
    @State var content = ""

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment:.leading) {
                Text("Create new Post")

                TextField ("Write Something", text: $content)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)

                Spacer()

            }.padding()
                .onAppear(perform: {
                    self.content = item.content
                })
        }
        .navigationBarTitle("Edit Post", displayMode: .inline )
        .navigationBarItems(trailing: trailing)
    }
    var trailing: some View{
        Button(action: {
            //update post
            if content != "" {
                let __: [String: Any] = ["id": item.id,  "post": content ]
              //  viewModel.updatePost(parameters: parameters)
                viewModel.fetchPosts()
                presetentionMode.wrappedValue.dismiss()
            } else {

            }
        }, label: {
            Text("Save")
        })
    }
}

