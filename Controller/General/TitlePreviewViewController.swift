//
//  TitlePreviewViewController.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 02/02/2023.
//

import UIKit
import WebKit
class TitlePreviewViewController: UIViewController {

    var model : TitlePreviewModel!
    
    var modelDownload : Title!
    @IBOutlet weak var dataLable: UILabel!
    @IBOutlet weak var voteCount: UIButton!
   
    static let identifer = "TitlePreviewViewController"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var overViewLabal: UILabel!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setButton()
        nameLabel.text = model.name
        overViewLabal.text = model.overview

        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youTubeView.id.videoId)")else{return}
        webView.load(URLRequest(url: url))
        
        dataLable.text = "Data : \(modelDownload.release_date!)"
        
        if modelDownload.vote_count! >= 500{
            
            voteCount.layer.cornerRadius = 10
            voteCount.setTitle("most liked", for: .normal)
            voteCount.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            voteCount.backgroundColor = .red
        }else{
            voteCount.setTitle("", for: .normal)
        }
        
    }
    func setButton(){
        downloadButton.backgroundColor = .red
        downloadButton.tintColor = .white
        downloadButton.layer.cornerRadius = 10
    }

    @IBAction func didTappedDownloadButton(_ sender: Any) {
        DataPersentaceManger.downLoadTitleWith(modal:modelDownload) {[weak self] result in
            switch result{
            case .success():
                print("Downloded successfully")
                NotificationCenter.default.post(name:NSNotification.Name("DownloadedFromPreViewViewController"), object: nil)
            case .failure(let error):
                print("Downloded failure",error)
            }
        }
        
        
    }
    //    func configure(wiht model :TitlePreviewModel){
//
//        nameLabel.text = model.name
//        overViewLabal.text = model.overview
//
//        guard let url = URL(string: "https://www.youtube.com/embd/\(model.youTubeView.id.videoId)")else{return}
//        webView.load(URLRequest(url: url))
//
//    }
}
