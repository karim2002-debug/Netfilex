//
//  SearchResultsViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 02/02/2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate{
    func searchResultsViewController(_ viewModal : TitlePreviewModel , title : Title)
}

class SearchResultsViewController: UIViewController {

    var delegate : SearchResultsViewControllerDelegate?
   public var titles : [Title] = [Title]()
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

         regester()
    }

    func regester(){
        
        searchResultCollectionView.register(UINib(nibName: TitleCollectionView.identifer, bundle: nil), forCellWithReuseIdentifier: TitleCollectionView.identifer)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        
    }

}
extension SearchResultsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionView.identifer, for: indexPath)as! TitleCollectionView
        let data = titles[indexPath.row]
        cell.configuer(model: data.poster_path ?? " ")
          return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        print("indexPath = ",indexPath.row)

        let titles = titles[indexPath.row]
        
        APICaller.getMovieFromYoutube(quary:titles.original_title ?? "") { response in
            let viewModal = TitlePreviewModel.init(name: titles.original_title ?? "", overview: titles.overview ?? "", youTubeView: response)
            let title = Title(id: titles.id, original_language: titles.original_language, original_title: titles.original_title, media_type: titles.media_type, poster_path: titles.poster_path, overview: titles.overview, vote_count: titles.vote_count, release_date: titles.release_date, vote_average: titles.vote_average)
            self.delegate?.searchResultsViewController(viewModal, title: title)
        }
    }
    
}


extension SearchResultsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width / 3.3, height: height / 4)
    }
    
}
