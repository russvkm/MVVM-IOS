//
//  NetworkService.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation

class NetworkService{
    init(){}
    
    // get request
    func apiCall<T:Decodable>(endPoint:String, completion:@escaping(Result<T, DataError>)->Void){
        guard let url = URL(string:"\(Constants.shared.baseUrl)\(endPoint)") else { return }
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {
                completion(.failure(.failure))
                return
            }
            
            do{
                let data = try JSONDecoder().decode(T.self, from: data)
                completion(.success(data))
            }catch{
                completion(.failure(.dataParseError))
            }
            
        }.resume()
    }
}

enum DataError:Error{
    case urlBreak
    case failure
    case dataParseError
}
