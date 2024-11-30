//
//  DataPersistenceManager.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 08/11/2024.
//

import Foundation
import CoreData
import UIKit
// respnsible downloading the data
class DataPersistenceManager{
    
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
        case failedToDeleteDataWith404
        case failedToCheckDownloadedData
    }
    static let shard = DataPersistenceManager()
    private init() {}
    
    func downloadTitleWith(model :Title , completion :@escaping (Result <Void , Error>) -> Void){
        
      
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let item = TitleItem(context: context)
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.original_language = model.original_language
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = item.vote_average
        do{
            try context.save()
//            completion(.success(()))
            
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
        
    }
    func fetchingTitlesFromDatabase(completion : @escaping (Result<[TitleItem],Error>)->Void){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
         let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let item = TitleItem(context: context)
        let request: NSFetchRequest<TitleItem>

       
        request = TitleItem.fetchRequest()
        do{
            let titles = try context.fetch(request)
            completion(.success( titles))
        }catch{
            completion(.failure( DatabaseError.failedToFetchData))
        }
    }
    
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>)-> Void) {
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
        
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
    }
    func isDownloaded(_ id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TitleItem> = TitleItem.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", NSNumber(value: id))
        fetchRequest.predicate = predicate
        
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        do {
            let result = try context.fetch(fetchRequest).first
            
            if let _ = result {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
            
        } catch {
            completion(.failure(DatabaseError.failedToCheckDownloadedData))
        }
    }
    func deleteTitleBy(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TitleItem> = TitleItem.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", NSNumber(value: id))
        fetchRequest.predicate = predicate
        
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        do {
            let result = try context.fetch(fetchRequest).first
            
            if let result = result {
                context.delete(result)
                
                try context.save()
                completion(.success(()))
            }
            
            completion(.failure(DatabaseError.failedToDeleteDataWith404))
            
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
}
