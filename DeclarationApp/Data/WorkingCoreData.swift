//
//  File.swift
//  DeclarationApp
//
//  Created by vika on 8/14/18.
//  Copyright © 2018 vika. All rights reserved.
//

import Foundation
import CoreData

class WorkingCoreData {
    
    var favorite:[FavoriteData] = []
    
    func someEntityExists(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteData")
        let predicateID = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicateID
        
        var results: [NSManagedObject] = []
        do {
            results = try AppDelegate.getContext().fetch(fetchRequest) as! [NSManagedObject]
            print(results)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    func fetchData() -> [FavoriteData]{
        
        do{
            favorite = try AppDelegate.getContext().fetch(FavoriteData.fetchRequest())
        }
        catch{
            print(error)
        }
        
        return favorite
    }
    
    func deleteRecord(id: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteData")
        let predicateID = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicateID
        let objects = try! AppDelegate.getContext().fetch(fetchRequest)
        
        for object in objects{
            AppDelegate.getContext().delete(object as! NSManagedObject)
        }
        
        do {
            try AppDelegate.getContext().save()
        } catch {
            print ("error executing fetch request: \(error)")
        }
    }
}
