//
//  TitleTableViewCell.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 01/02/2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

   // var upcomingInfo : [Title] = [Title]()
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var posterName: UILabel!
    
 static let identfier = "TitleTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    public func confuger(with modal :TitleViewModel  ){
        
        guard let url = URL(string:"https://image.tmdb.org/t/p/w342/\(modal.posterUrl)" ) else {return}
        
        posterName.text = modal.titleNames
        posterImageView.sd_setImage(with: url)
        
    
    }
    
    
}
