//
//  ContentView.swift
//  Posts
//
//  Created by Emilly Maia on 10/08/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State var content = ""
    
    
    var body: some View {
            List {
                ForEach (viewModel.items, id: \.id) { item in
                    VStack(alignment: .leading){
                        Text(item.content).font(.caption).foregroundColor(.black)
                    }
                }
                
            }
            .listStyle(.plain)
            .navigationBarTitle("Posts")
            .navigationBarItems(trailing: plusButton)
            .sheet(isPresented: $isPresentedNewPost , content: {
                    NewPostView (isPresented: $isPresentedNewPost, content: $content)
            })
            
    }
    

    
    var plusButton: some View {
        Button(action: {
            isPresentedNewPost.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



