//
//  ViewModel.swift
//  Posts
//
//  Created by Emilly Maia on 10/08/22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var items = [PostModel]()
    let prefixUrl = "http://adaspace.local"
    init() {
        fetchPosts()
    }
    
    //MARK: - recuperar/ver dados (posts)
    func fetchPosts() {
//aqui a constante que armazena a URL que queremos pegar os dados
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("nao achei")
            return
        }
//caso não mostre os usuários por algum motivo, aqui captamos o erro pra printar no terminal
        URLSession.shared.dataTask(with: url) {(data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }

//pegando os posts no formato da api (JSON) e decodando pro formato PostModel, que é uma struct que a gente criou :)))
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([PostModel].self, from: data)
                    DispatchQueue.main.async {
                        self.items = result
                    }
                } else {
                    print("No data")
                }
//se der erro no arquivo JSON que a gente requisitar, aqui printamos no terminal o erro.
            }catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }
    
    //MARK: - Criando post
    
    func createPost(parameters: [String: Any]) {
//aqui a constante que armazena a URL que queremos pegar os dados
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("nao achei")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
  
//requisição pra fazer um POST(enviar dados) pra API. Requisição que chama
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {(data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No data")
                }
                
            }catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }
    
}
