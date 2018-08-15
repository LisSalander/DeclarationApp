//
//  FavoriteTableView.swift
//  DeclarationApp
//
//  Created by vika on 8/13/18.
//  Copyright © 2018 vika. All rights reserved.
//

import UIKit

class FavoriteTableView: UITableViewController {

    var favorite:[FavoriteData] = []
    let workingCoreData = WorkingCoreData()
    
    var indexPathRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favorite = workingCoreData.fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "loadFavorite"), object: nil)
        
    }

    
    @IBAction func editNoteButton(_ sender: Any) {
        
        let indexPath = tableView?.indexPath(for: (((sender as AnyObject).superview??.superview) as! UITableViewCell))
        indexPathRow = (indexPath?.row)!
        
        performSegue(withIdentifier: "EditNote", sender: self)
    }


    @objc func reloadData() {
        
        favorite = workingCoreData.fetchData()
        tableView.reloadData()
    }
  

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorite.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! TableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.favoriteFirstNameLabel.text = favorite[indexPath.row].firstName
        cell.favoriteLastNameLabel.text = favorite[indexPath.row].lastName
        cell.favoritePlaceOfWorkLabel.text = favorite[indexPath.row].placeOfWork
        cell.noteLabel.text = favorite[indexPath.row].note
        cell.favoritePositionLabel.text = favorite[indexPath.row].position

        return cell
    }
   
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pdfScene =  segue.destination as? PdfViewController,
            let indexPath = tableView?.indexPath(for: (((sender as AnyObject).superview??.superview) as! UITableViewCell)){
            
            let selectedVehicle = favorite[indexPath.row]
            pdfScene.pdfURL = selectedVehicle.linkPdf!
        }
        
        if let notesScene =  segue.destination as? NotesViewController{
            
            let selectedVehicle = favorite[indexPathRow]
            notesScene.firstName = selectedVehicle.firstName!
            notesScene.lastName = selectedVehicle.lastName!
            notesScene.placeOfWork = selectedVehicle.placeOfWork!
            notesScene.pdfURL = selectedVehicle.linkPdf!
            notesScene.id = selectedVehicle.id!
            notesScene.position = selectedVehicle.position!
            notesScene.note = selectedVehicle.note!
        
        }
    }

}
