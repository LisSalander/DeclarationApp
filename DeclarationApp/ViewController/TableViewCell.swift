//
//  TableViewCell.swift
//  DeclarationApp
//
//  Created by vika on 8/11/18.
//  Copyright © 2018 vika. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    //Declaration TableView
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var placeOfWorkLabel: UILabel!
    
    //Favorite Table View
    
    @IBOutlet weak var favoritePositionLabel: UILabel!
    @IBOutlet weak var favoritePlaceOfWorkLabel: UILabel!
    @IBOutlet weak var favoriteFirstNameLabel: UILabel!
    @IBOutlet weak var favoriteLastNameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
  

}
