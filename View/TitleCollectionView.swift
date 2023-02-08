//
//  CollectionView.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 25/10/2022.
//

import UIKit
import SDWebImage
class TitleCollectionView: UICollectionViewCell {

    
    var title : Title!
    
    @IBOutlet weak var PosterImageView: UIImageView!
    static let identifer = "TitleCollectionView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PosterImageView.layer.cornerRadius = 15
        
    
    }

    public func configuer(model : String){
        
//    guard let url = URL(string: model)else{return}
//   PosterImageView.sd_setImage(with: url,completed: nil)
//     
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342/\(model)")else {return}
        PosterImageView.sd_setImage(with: url,completed: nil)
        print(model)
    }
    
}
