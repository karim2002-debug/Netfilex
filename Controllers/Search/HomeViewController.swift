//
//  HomeViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 25/10/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
   
       
        
        regester()
    }

    func regester(){
        
        
    
        tableView.register(UINib(nibName: CollectionViewInTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: CollectionViewInTableViewCell.identifer)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 400))
        tableView.tableHeaderView?.backgroundColor = .systemPink
        
    }

    
     

}


extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    
  
    func numberOfSections(in tableView: UITableView) -> Int {
        20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CollectionViewInTableViewCell.identifer, for: indexPath)
        cell.textLabel?.text = "Karim"
        cell.backgroundColor = .systemPink
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
 }
