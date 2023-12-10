//
//  HomeScreenController.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation
import UIKit

class HomeScreenController:UIViewController{
    private let homeScreenViewModel = HomeScreenViewModel()
    private var dataModel:[ProductModal] = [ProductModal]()
    @IBOutlet weak var dataTable:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData(){
        dataTable.dataSource = self
        dataTable.delegate = self
        observeEvent()
        homeScreenViewModel.fetchProduct()
    }
    
    private func observeEvent(){
        homeScreenViewModel.eventHandler = { [weak self]
            event in
            switch event {
            case .loading:
                print("loading....")
                break
            case .sucess(let product):
                self?.dataModel = product
                DispatchQueue.main.async {
                    self?.dataTable.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension HomeScreenController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell")
        cell?.textLabel?.text = dataModel[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}
