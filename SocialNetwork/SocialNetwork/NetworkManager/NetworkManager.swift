//
//  NetworkManager.swift
//  SocialNetwork
//
//  Created by Евгений on 8.09.21.
//

import Foundation

enum NetworkError: Error {
    case domainError
    case decodingError
}

enum UserFields: String {
    case photo50 = "photo_50"
    case photo100 = "photo_100"
    case home = "home_town"
    case city = "city"
    case country = "country"
    case sex = "sex"
    case birthData = "bdate"
}

class NetworkManager {
    
    private init () {}
    
    static let shared = NetworkManager()
    
    var accessToken: Token?
    
    let urlAuth = "https://oauth.vk.com/authorize?client_id=7943589&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52"
    private let serverUrl = "https://api.vk.com/method/"
    
    //let getUser = serverPath + "users.get?user_ids=\(String(describing: NetworkManager.shared.accessToken?.userId))"
    
    func createUrlWithParams(method: String, params: [String : Any]) -> URL? {
        let token = (NetworkManager.shared.accessToken?.token)!
        //let userId = (NetworkManager.shared.accessToken?.userId)!
        
        //var paramsDict: [String: Any] = ["access_token": token, "user_ids": userId, "v": "5.131"]
        var paramsDict: [String : Any] = ["access_token": token, "v": "5.131"]

        params.forEach { (key, value) in
            paramsDict[key] = value
        }
        
        let paramsStr: String = paramsDict.map { "\($0)=\($1)" }.joined(separator: "&")
        

        let urlString = serverUrl + method + "?" + paramsStr
        return URL(string: urlString)
    }
    
//    func fetchUser() {
//        guard let url = NetworkManager.shared.createUrlWithParams(method: "users.get", params: ["fields": "photo_max"]) else { return }
//        var user: User?
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//            do {
//                struct Response: Decodable {
//                    var response: [User]?
//                }
//                let response = try JSONDecoder().decode(Response.self, from: data)
//                user = (response.response?.first)
////                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
////                    print(json)
////                }
//                //print(user)
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    
    func performRequest(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(nil, error)
                }
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(data, nil)
                    //проверить на ошибку token expiration
                    //если ошибка на токен - > перезапрашиваем токен
                }
            } catch let e {
                completion(nil, e)
            }
            
        }
        task.resume()
    }

    func getUsers(userId: String, completion: @escaping (Result<User,NetworkError>) -> Void) {
        struct Response: Decodable {
            var response: [User]?
        }
        
        guard let url = createUrlWithParams(method: "users.get", params: ["fields" : ["photo_max", "sex"], "user_ids": userId]) else { return }
        
        var user: User?
        performRequest(url: url) { data, error in

            do {
                let respone = try JSONDecoder().decode(Response.self, from: data!)
                user = respone.response?.first
                completion(.success(user!))
            } catch {
                completion(.failure(.decodingError))
            }

        }
        
    }
        
}
    

//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

//https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
