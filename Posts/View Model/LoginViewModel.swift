//
//  LoginViewModel.swift
//  Posts
//
//  Created by Emilly Maia on 17/08/22.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
//criando variáveis pra pegar o input do usuário
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
  
    
//usando a função do webservice pra validar o login do usuário com a API.
    func login(completionHandler: @escaping (Bool, Error?) -> Void)  {
        let defaults = UserDefaults.standard
        WebService().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "token")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
                
                completionHandler(true, nil)
                
                
            case .failure(let error):
                print(error.localizedDescription)
                
                completionHandler(false, error)
            }
        }
    }
}
