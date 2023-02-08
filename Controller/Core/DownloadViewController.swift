//
//  DownloadViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 25/10/2022.
//

import UIKit

class DownloadViewController: UIViewController {

    
    
    var downLoadList : [TitleItem] = [TitleItem]()
    @IBOutlet weak var downLaodedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "DownLoad"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        regester()
        fetchingWhatYouDownLoaded()
        getNofication()
     }
    
    
    private func getNofication(){
        NotificationCenter.default.addObserver(forName:NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchingWhatYouDownLoaded()
        }
        NotificationCenter.default.addObserver(forName:NSNotification.Name("DownloadedFromPreViewViewController"), object: nil, queue: nil) { _ in
            self.fetchingWhatYouDownLoaded()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("DownloadedButton"), object: nil, queue: nil) { _ in
            self.fetchingWhatYouDownLoaded()
        }
    }
    
    

    private func regester(){
        downLaodedTableView.delegate =  self
        downLaodedTableView.dataSource = self
        downLaodedTableView.register(UINib(nibName: TitleTableViewCell.identfier, bundle: nil), forCellReuseIdentifier: TitleTableViewCell.identfier)
    }
    
    private func fetchingWhatYouDownLoaded(){
        
        DataPersentaceManger.fetchingTitlesFromDataBase { [weak self] results in
            switch results{
            case .success(let titles):
                self?.downLoadList = titles
                self?.downLaodedTableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
            
             
        }
    }
  

}
 

extension DownloadViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downLoadList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identfier, for: indexPath)as! TitleTableViewCell
        let data  = downLoadList[indexPath.row]
        print("Name ",data.original_title)
        let viewModal = TitleViewModel.init(titleNames: data.original_title ?? "UN KNOWN " , posterUrl: data.poster_path ?? "" )
        cell.confuger(with: viewModal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let titles = downLoadList[indexPath.row]
        
        APICaller.getMovieFromYoutube(quary: titles.original_title ?? "") { result in
           
            let Preview = TitlePreviewModel(name: titles.original_title ?? " ", overview: titles.overview ?? " ", youTubeView: result)
            
            
            let modal = Title(id: Int(titles.id), original_language: titles.original_language, original_title: titles.original_title, media_type: titles.media_type, poster_path: titles.poster_path, overview: titles.overview, vote_count: Int(titles.vote_count), release_date: titles.release_date, vote_average: titles.vote_average)
            
            let vc  = TitlePreviewViewController()
            vc.model = Preview
            vc.modelDownload = modal
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
          
        
        //Redirector
        //
        
    }
    
    // the red thing which apper in the right when you swap the cell to delete
    // Used to delete the element
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Are you sure ?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "delete", style: .destructive,handler: { _ in
            switch editingStyle{
               case .delete:
                let modal = self.downLoadList[indexPath.row]
                DataPersentaceManger.deleteTitleWith(modal: modal) {[weak self] results in
                    switch results{
                    case .success():
                        print("Deleted From Datbase")
                        
                    case .failure(let error):
                        print(error)
                    }
                    self?.downLoadList.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            default : break
            }
        }))
       
        present(alert, animated: true)
        
    }
}
