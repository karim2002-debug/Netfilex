//
//  DataPersentaceManger.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 03/02/2023.
//

import Foundation
import UIKit
import CoreData
class DataPersentaceManger{
    
    
    // To make downLoad to dataBase
    static func downLoadTitleWith(modal : Title,completionHandler : @escaping(Result<Void , Error>)->Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.original_title = modal.original_title
        item.overview = modal.overview
        item.id = Int64(modal.id!)
        item.poster_path = modal.poster_path
        item.media_type = modal.media_type
        item.release_date = modal.release_date
        item.original_language = modal.original_language
        item.vote_count = Int64(modal.vote_count!)
        item.vote_average = modal.vote_average!
        
        
        do{
            try context.save()
            completionHandler(.success(()))
        }catch let error{
            
            print(error)
        }
    }
    
    
    static func fetchingTitlesFromDataBase(completionHandler : @escaping (Result<[TitleItem],Error>)->Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do{
            
            let titles = try context.fetch(request)
            completionHandler(.success(titles))
        }catch{
            
            completionHandler(.failure(error))
            
        }
        
    }
    
    
    static func deleteTitleWith(modal : TitleItem , complationHandler : @escaping (Result<Void , Error>)->Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(modal)
        
        do{
            
            try context.save()
        }catch let error{
            print(error)
        }
        
    }
    
}
