//
//  FavoriteData+CoreDataProperties.swift
//  DeclarationApp
//
//  Created by vika on 8/13/18.
//  Copyright © 2018 vika. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteData> {
        return NSFetchRequest<FavoriteData>(entityName: "FavoriteData")
    }

    @NSManaged public var note: String?
    @NSManaged public var id: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var placeOfWork: String?
    @NSManaged public var position: String?
    @NSManaged public var linkPdf: String?

}
