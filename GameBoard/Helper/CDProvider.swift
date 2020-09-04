//
//  CDProvider.swift
//  GameBoard
//
//  Created by Farras Doko on 18/08/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import Foundation
import CoreData

class CDProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteGame")
        
        container.loadPersistentStores {
            psDesc, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getData(completion: @escaping(_ fGames: [FavGameModel]) -> Void){
        let taskContext = newContext()
        taskContext.perform {
            let req = NSFetchRequest<NSManagedObject>(entityName: "FavGame")
            do {
                let results = try taskContext.fetch(req)
                var games = [FavGameModel]()
                for result in results {
                    let game = FavGameModel(id: result.value(forKeyPath: "id") as? Int32,
                                              image: result.value(forKeyPath: "image") as? Data,
                                              title: result.value(forKeyPath: "title") as? String,
                                              publisher: result.value(forKeyPath: "publisher") as? String,
                                              year: result.value(forKeyPath: "year") as? String,
                                              platforms: result.value(forKeyPath: "platforms") as? String,
                                              site: result.value(forKeyPath: "site") as? String,
                                              genre: result.value(forKeyPath: "genre") as? String,
                                              body: result.value(forKeyPath: "body") as? String,
                                              rating: result.value(forKey: "rating") as? Float)
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getData(with id: Int, completion: @escaping(_ fGame: FavGameModel?) -> Void) {
        let taskContext = newContext()
        taskContext.perform {
            let req = NSFetchRequest<NSManagedObject>(entityName: "FavGame")
            req.predicate = NSPredicate(format: "id == \(id)")
            
            do {
                let result = try taskContext.fetch(req)
                let game = FavGameModel(id: result.first?.value(forKeyPath: "id") as? Int32,
                image: result.first?.value(forKeyPath: "image") as? Data,
                title: result.first?.value(forKeyPath: "title") as? String,
                publisher: result.first?.value(forKeyPath: "publisher") as? String,
                year: result.first?.value(forKeyPath: "year") as? String,
                platforms: result.first?.value(forKeyPath: "platforms") as? String,
                site: result.first?.value(forKeyPath: "site") as? String,
                genre: result.first?.value(forKeyPath: "genre") as? String,
                body: result.first?.value(forKeyPath: "body") as? String)
                completion(game)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func createData(id: Int,_ image: Data,_ title: String,_ publisher: String,_ year: String,_ platforms: String,_ site: String,_ genre: String,_ body: String, _ rate: Float, completion: @escaping() -> Void) {
        let taskContext = newContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "FavGame", in: taskContext) {
                let games = NSManagedObject(entity: entity, insertInto: taskContext)
                games.setValue(id, forKey: "id")
                games.setValue(title, forKey: "title")
                games.setValue(image, forKey: "image")
                games.setValue(publisher, forKey: "publisher")
                games.setValue(year, forKey: "year")
                games.setValue(platforms, forKey: "platforms")
                games.setValue(site, forKey: "site")
                games.setValue(genre, forKey: "genre")
                games.setValue(body, forKey: "body")
                games.setValue(rate, forKey: "rating")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            }
        }
    }
    
    func deleteData(_ id: Int, completion: @escaping() -> Void){
        let taskContext = newContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavGame")
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
