//
//  SearchViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 25/10/2022.
//

import UIKit

class SearchViewController: UIViewController  {
  
    

    var searchList : [Title] = [Title]()
    
    let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    
    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationInfo()
         regester()
        fetchDiscover()
        
        
        searchController.searchBar.placeholder = "Search for Movie or Tv show "
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        
        searchController.searchResultsUpdater = self
     }

    func setNavigationInfo(){
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        
    }
    
    func regester(){
        searchTableView.register(UINib(nibName: TitleTableViewCell.identfier, bundle: nil), forCellReuseIdentifier: TitleTableViewCell.identfier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

   private func fetchDiscover(){
       APICaller.getDiscover { response in
           self.searchList = response.results
           self.searchTableView.reloadData()
       }
    }
    
    
    
}
extension SearchViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identfier, for: indexPath)as! TitleTableViewCell
        let data = searchList[indexPath.row]
        cell.confuger(with: TitleViewModel.init(titleNames: data.original_title ?? "UN KNOWN", posterUrl: data.poster_path ?? ""))
         return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("indexPath = ",indexPath.row)
        
        let title = searchList[indexPath.row]
        APICaller.getMovieFromYoutube(quary: title.original_title ?? "") { response in
            let viewModal = TitlePreviewModel.init(name: title.original_title ?? "", overview: title.overview ?? "", youTubeView: response)
            
            let vc = TitlePreviewViewController()
            vc.model = viewModal
            vc.modelDownload = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}



// TO MAKE SEARCH
extension SearchViewController : UISearchResultsUpdating,SearchResultsViewControllerDelegate
{
   
    
       func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar  = searchController.searchBar
        
        guard let quary = searchBar.text,
            
                !quary.trimmingCharacters(in: .whitespaces).isEmpty,// query != nil
              quary.trimmingCharacters(in: .whitespaces).count >= 3, // the character not less than 3
                
                // to send the result to SearchResultsViewController
                let resultsController = searchController.searchResultsController as? SearchResultsViewController else{return}
        APICaller.search(query: quary) { response in
            resultsController.titles = response.results
            resultsController.searchResultCollectionView.reloadData()
        }
        
       resultsController.delegate = self
        
    }
    func searchResultsViewController(_ viewModal: TitlePreviewModel, title: Title) {
        let vc = TitlePreviewViewController()
        vc.model = viewModal
        vc.modelDownload = title
        navigationController?.pushViewController(vc, animated: true)
    }    
}
