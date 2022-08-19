//
//  WebService.swift
//  Posts
//
//  Created by Emilly Maia on 17/08/22.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}
struct Session: Codable {
    let token: String?
    let user: User
}

class WebService {
 //função que vê as contas existentes na API
    func getAllAccounts(token: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://adaspace.local/users") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
            
            
            
        }.resume()
        
        
    }
    
//função que permite a gente fazer o login no app
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "http://adaspace.local/users/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }

        let body = LoginRequestBody(email: email, password: password)
        let bodyStr = "\(body.email):\(body.password)"
        let bodydata = bodyStr.data(using: .utf8)!
        let bodybase64 = bodydata.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("Basic \(bodybase64)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            do {
                print(try! JSONSerialization.jsonObject(with: data))
                let loginResponse = try JSONDecoder().decode(Session.self, from: data)
                completion(.success("Usuário logado"))
                print(loginResponse)
            } catch {
                print(error.localizedDescription)
            }
         
        }.resume()
        
    }
    
    func registerUser(nome: String, email: String, password: String) async throws {
        let userModel = UserCreate(name: nome, email: email, password: password)
        
        let newUserJson =  try JSONEncoder().encode(userModel)
        guard let url = URL(string: "http://adaspace.local/users") else
        {
            print("nao ta funcionando")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = newUserJson
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let string = String(data: data, encoding: .utf8)!
            print(string)
        }
    }

    
}
