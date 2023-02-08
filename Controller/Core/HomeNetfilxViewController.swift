//
//  HomeViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 25/10/2022.
//

import UIKit

import Alamofire
 
enum section : Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRatd = 4
  
}




 
class HomeNetfilxViewController: UIViewController {
    
    
    private var titles : [Title] = [Title]()
    var sectionTitle : [String] = ["Trending Movies","Popular","Trending tv","Upcoming Movies","Top ratd"]
   
    
     
 
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var HeaderImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Netflix"
         setView()
        view.backgroundColor = .systemBackground
   
 
        configuerNavBar()
        regester()
        
        configuerHeaderImageView()
        tableView.separatorColor = .systemBackground
    }
    
    func setView(){
        
        HeaderImageView.layer.cornerRadius = 10
       
         playButton.layer.borderColor = UIColor.white.cgColor
        downloadButton.layer.borderColor = UIColor.white.cgColor

        playButton.layer.borderWidth = 1
        downloadButton.layer.borderWidth = 1

        
        playButton.layer.cornerRadius = 5
        downloadButton.layer.cornerRadius = 5
        
    }
    func configer(with model : TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342/\(model.posterUrl)")else {return}
        HeaderImageView.sd_setImage(with: url,completed: nil)
 
    }
    var selectTitle : Title!
    var overView : String!
    var viewModel : TitleViewModel!
    // func to put the random image in header view
    private func configuerHeaderImageView(){
        
        APICaller.getTrandingMovie { [weak self] response in
            
            self!.selectTitle = response.results.randomElement()
            //self.titles = response.results.randomElement()
            self!.overView = self!.selectTitle?.overview
           
            self!.viewModel = TitleViewModel.init(titleNames: self!.selectTitle?.original_title ?? "UN KNOWN", posterUrl: self!.selectTitle?.poster_path ?? " ")
  self?.configer(with: (self?.viewModel)!)
            
      }
}
    
    
    @IBAction func downloadButton(_ sender: Any) {
        
        
        print("selectTitle = ",selectTitle)
        DataPersentaceManger.downLoadTitleWith(modal: selectTitle) { result in
            switch result{
            case .success():
                print("Downloaded")
                NotificationCenter.default.post(name: NSNotification.Name("DownloadedButton"), object: nil)
                
                let alert = UIAlertController(title: "Downloded successfully", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .cancel))
                alert.addAction(UIAlertAction(title: "Watch the Movie", style: .default, handler: { _ in
                    print("Every thing is ok")
                    let vc = DownloadViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }))
                self.present(alert, animated: true)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
@IBAction func playButton(_ sender: Any) {
        let movieName = viewModel.titleNames
       
        APICaller.getMovieFromYoutube(quary: movieName) { result in
            let title = TitlePreviewModel.init(name: movieName, overview: self.overView, youTubeView: result)
            let vc = TitlePreviewViewController()
            vc.model = title
            vc.modelDownload = self.selectTitle
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
       
 }
    
      private func  configuerNavBar(){
        
        
      var image = UIImage(named: "net")
       
       image = image?.withRenderingMode(.alwaysOriginal) // to make the image with the same with in assets
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
        
        
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
            
        ]
        navigationController?.navigationBar.tintColor = UIColor(named: "headerColor")
    }
    func regester(){
        
        
    
        tableView.register(UINib(nibName: CollectionViewInTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: CollectionViewInTableViewCell.identifer)
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 400))
//        tableView.tableHeaderView?.backgroundColor = .systemPink
    }

   
    
     

}


extension HomeNetfilxViewController : UITableViewDelegate , UITableViewDataSource{
    
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier:CollectionViewInTableViewCell.identifer, for: indexPath)as! CollectionViewInTableViewCell
        cell.delegate = self
        cell.backgroundColor = .systemPink
 
        switch indexPath.section{ // section 0

        case section.TrendingMovies.rawValue:
            APICaller.getTrandingMovie { response  in

                cell.configuers(titles: response.results)
            }
  
         
        case section.TrendingTv.rawValue: // section 1
            APICaller.getTrendingTv{ response  in
                 
                cell.configuers(titles: response.results)
                print("hereee = ",response.results)
              

            }
            
        case section.Upcoming.rawValue: // section 2
            APICaller.getUpcomingMovies{ response  in
           
                cell.configuers(titles: response.results)
             }
            
        case section.Popular.rawValue: // section 3
            APICaller.getPopular{ response  in
                 cell.configuers(titles: response.results)
            }
            
            
        case section.TopRatd.rawValue: // section 4
            APICaller.getTopRated{ response  in
               
                cell.configuers(titles: response.results)
            }
            

        default :
            return UITableViewCell()
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        37
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // to initliz the section titles from array
        return sectionTitle[section]
    }
    
    
    //
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // to make edit on header text
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
       // header.textLabel?.textColor = .white
        
        header.textLabel?.textColor = UIColor(named: "headerColor")
        
        header.textLabel?.text = header.textLabel?.text?.captialTheFirstLetter()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // to make navigation Bar hide when you scroll down
        
        let defualtOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defualtOffset
        
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,  -offset))
    }
    
    
    
}



extension HomeNetfilxViewController : CollectionViewTableViewDelegate{
    func collectionViewTableViewDelegateDidTapped(_ cell: CollectionViewInTableViewCell, viewModal: TitlePreviewModel, title: Title) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
           print("viewModal = ",viewModal)
           vc.model = viewModal
            vc.modelDownload = title
          //  vc.configure(wiht: viewModal)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
 
    
}
