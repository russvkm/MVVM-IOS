//
//  HomeScreenViewModel.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation


class HomeScreenViewModel{
    var eventHandler:((_ event:Event<ProductModal>)->Void)?
    
    func fetchProduct(){
        self.eventHandler?(.loading)
        NetworkService().apiCall(endPoint: "products") { (result:Result<[ProductModal], DataError>) in
            switch result{
            case .success(let model):
                self.eventHandler?(.sucess(model))
                print(model)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}

enum Event<T>{
    case loading
    case sucess(_ product:[T])
    case error(_ error:Error)
}

