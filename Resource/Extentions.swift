//
//  Extentions.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 15/12/2022.
//

import Foundation
extension String{
    
    // this used to make the first letter of the word captial
    func captialTheFirstLetter()->String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    
    
}
 
