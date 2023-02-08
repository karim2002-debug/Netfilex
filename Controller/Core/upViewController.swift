//
//  upViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 01/02/2023.
//

import UIKit

class upViewController: UIViewController {

    var upComingList : [Title] = [Title]()
    
    @IBOutlet weak var upTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Up Coming"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        APICaller.getUpcomingMovies { response in
            self.upComingList = response.results
            self.upTable.reloadData()
        }
        
        regster()
    }


    func regster(){
        
        upTable.dataSource = self
        upTable.delegate = self
        
        upTable.register(UINib(nibName: TitleTableViewCell.identfier, bundle: nil), forCellReuseIdentifier: TitleTableViewCell.identfier)
        
    }
}
extension upViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identfier, for: indexPath)as! TitleTableViewCell
       let data = upComingList[indexPath.row]
        
        cell.confuger(with: TitleViewModel(titleNames: data.original_title ?? "UN KNOW" , posterUrl: data.poster_path ?? "") )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        
        let title = upComingList[indexPath.row]
       
        APICaller.getMovieFromYoutube(quary: (title.original_title ?? " ") + " trailer" ) { response in
            print("result",response.id.videoId)
            let viewModal = TitlePreviewModel.init(name:title.original_title ?? " ", overview: title.overview ?? " ", youTubeView: response)
            let vc = TitlePreviewViewController()
            vc.model = viewModal
            vc.modelDownload = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
