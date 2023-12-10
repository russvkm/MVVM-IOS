//
//  UsersViewModel.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation
class UsersViewModel{
    var eventHandler:((_ event:Event<UserModel>)->Void)?
    
    func getData(){
        NetworkService().apiCall(endPoint: "users") { [weak self] (response:Result<[UserModel], DataError>) in
            self?.eventHandler?(.loading)
            switch response{
            case .success(let value):
                self?.eventHandler?(.sucess(value))
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}


