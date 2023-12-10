//
//  UsersController.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation
import UIKit

class UsersController:UIViewController{
    @IBOutlet weak var userList:UITableView!
    let userViewModel:UsersViewModel = UsersViewModel()
    var users:[UserModel] = [UserModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //nodeLabel.text = "My name"
        userList.dataSource = self
        getData()
        
    }
}

extension UsersController{
    private func getData(){
        observeEvent()
        userViewModel.getData()
    }
    
    private func observeEvent(){
        userViewModel.eventHandler = { [weak self]
            event in
            switch event {
            case .loading:
                break
            case .sucess(let data):
                self?.users = data
                DispatchQueue.main.async {
                    self?.userList.reloadData()
                }
                print(data)
            case .error(let error):
                print(error)
            }
        }
    }
}

extension UsersController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath)
        cell.textLabel?.text = "\(users[indexPath.row].username ?? "") \(users[indexPath.row].email ?? "")"
        return cell
    }
    
    
}

