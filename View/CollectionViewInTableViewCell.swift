//
//  CollectionViewInTableViewCell.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 25/10/2022.
//

import UIKit



// Table View



protocol CollectionViewTableViewDelegate : AnyObject {
    func collectionViewTableViewDelegateDidTapped(_ cell : CollectionViewInTableViewCell , viewModal : TitlePreviewModel , title : Title)
   // func collectionViewTableViewDelegateDidTappedToDownload( _ cell : CollectionViewInTableViewCell , title : Title)
}


class CollectionViewInTableViewCell: UITableViewCell {
    
    static let identifer = "CollectionViewInTableViewCell"

    weak var delegate : CollectionViewTableViewDelegate?
    
    
    private var titles : [Title] = [Title]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        regestercollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func regestercollectionView(){
        
        
        collectionView.register(UINib(nibName: TitleCollectionView.identifer, bundle: nil), forCellWithReuseIdentifier: TitleCollectionView.identifer)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    
   public func configuers(titles : [Title]){
        self.titles = titles
       DispatchQueue.main.async { [weak self] in
           self?.collectionView.reloadData()
       }
    }
    
    
    // Used when press on film and downLoad button show click on the button and do this fun
    private func downloadTitleAt(indexPath : IndexPath){
 
        DataPersentaceManger.downLoadTitleWith(modal: titles[indexPath.row]) { result in
            
            switch result{
            case .success():
                print("DownLoaded")
                // to send the film which we downloaded to the downloadViewController without close and open the program
                NotificationCenter.default.post(name:NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension CollectionViewInTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionView.identifer, for: indexPath) as! TitleCollectionView
        
        cell.backgroundColor = .systemYellow
        guard let modal = titles[indexPath.row].poster_path else{return UICollectionViewCell()}
        cell.configuer(model:modal)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.row)
        
        let title = titles[indexPath.row]
        
        print(title.original_title)
        guard title.original_title! != nil else{return}
        
  
        APICaller.getMovieFromYoutube(quary: (title.original_title!) + " trailer") { [weak self] result in
            print("result",result.id.videoId)
          //  let data = titles[indexPath.row]
            let data = self?.titles[indexPath.row]
            guard let titleName = data?.original_title else{return}
            guard let titleOverView = data?.overview else{return}
            print("titleName = ",titleName)
            print("overv = ",titleOverView)

            guard let strongSelf = self else{
                return
            }
            print(result)
            let viewModal = TitlePreviewModel(name: titleName, overview: titleOverView, youTubeView: result)
            let title = Title(id: data?.id, original_language: data?.original_language, original_title: data?.original_title, media_type: data?.media_type, poster_path: data?.poster_path, overview: data?.overview, vote_count: data?.vote_count, release_date: data?.release_date, vote_average: data?.vote_average)
            self?.delegate?.collectionViewTableViewDelegateDidTapped(strongSelf, viewModal: viewModal, title: title)
           
           // self?.delegate?.collectionViewTableViewDelegateDidTappedToDownload(strongSelf, title: title)
        }
    }
     
    // when you press Alot on table View like in whatsAPP()
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let downloadAction = UIAction(title: "DownLoad", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil,   state: .off) { _ in
                self.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
    }
}

extension CollectionViewInTableViewCell : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width
        
        
        return CGSize(width: width / 3.1, height: height)
    }
    
    
}
