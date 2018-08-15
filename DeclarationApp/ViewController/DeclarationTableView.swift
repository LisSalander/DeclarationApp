
//
//  DeclarationTableView.swift
//  DeclarationApp
//
//  Created by vika on 8/11/18.
//  Copyright © 2018 vika. All rights reserved.
//

import UIKit
import CoreData

class DeclarationTableView: UITableViewController, UISearchResultsUpdating {
    
    var declarations = [DeclarationData]()
    var filteredData = [FilteredData]()
    let loadData = LoadData()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var convertData = ConvertData()
    var workingCoreData = WorkingCoreData()
    var batchSize = Int()
    var favorite:[FavoriteData] = []
    var indexPathRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        favorite = workingCoreData.fetchData()
        loadDeclarationData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckInternet.Connection(){
            print("Internet connection OK")
        }else{
            
            self.Alert(Message: "Make sure your device is connected to the internet.")
        }
        
    }
    
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "No Internet Connection", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func loadDeclarationData(){
    
        let activityIndicator = UIActivityIndicatorView()
        tableView.backgroundView = activityIndicator
        activityIndicator.color = .orange
        activityIndicator.startAnimating()
        
        loadData.downloadData(URL_DATA: Constants.declarationUrl){
            
            self.batchSize = self.loadData.returnSize()
            self.declarations = self.loadData.returnData()
            
            if self.declarations.count == self.loadData.batchSize{
                activityIndicator.stopAnimating()
                self.reloadTableView()
                self.searchController()
            }
        }
    }
    
    @objc func reloadData() {
        
        favorite = workingCoreData.fetchData()
        tableView.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadFavorite"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func reloadTableView(){
        
        filteredData = convertData.createStruct(declaration: declarations)
        resultSearchController.searchBar.showsCancelButton = false
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
        
    }

    @IBAction func addToFavorite(_ sender: Any) {
        
        let indexPath = tableView?.indexPath(for: (((sender as AnyObject).superview??.superview) as! UITableViewCell))
        indexPathRow = (indexPath?.row)!
        
        if workingCoreData.someEntityExists(id: filteredData[indexPathRow].id!){
            workingCoreData.deleteRecord(id: filteredData[indexPathRow].id!)
            reloadData()
        } else {
            performSegue(withIdentifier: "NoteView", sender: self)
        }
        
    }
    
    // MARK: - Search Controller
    
    func searchController() {
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.tintColor = .orange
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        let firstName = convertData.convertDataInArray(id: 1, declaration: declarations)
        let arrayFirstName:[String] = (firstName as NSArray).filtered(using: searchPredicate) as! [String]
        let lastName = convertData.convertDataInArray(id: 2, declaration: declarations)
        let arrayLastName:[String] = (lastName as NSArray).filtered(using: searchPredicate) as! [String]
        let placeOfWork = convertData.convertDataInArray(id: 3, declaration: declarations)
        let arrayPlaceOfWork:[String] = (placeOfWork as NSArray).filtered(using: searchPredicate) as! [String]
        let position = convertData.convertDataInArray(id: 4, declaration: declarations)
        let arrayPosition:[String] = (position as NSArray).filtered(using: searchPredicate) as! [String]
        
        let array =  arrayFirstName + arrayLastName + arrayPlaceOfWork + arrayPosition
        filteredTableData = array
        filteredData = convertData.convertFilterdData(data: filteredTableData, declaration: declarations)
        
        
        if resultSearchController.isActive == false{
            filteredData = convertData.createStruct(declaration: declarations)
            tableView.reloadData()
        }
        
       tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if self.workingCoreData.someEntityExists(id: self.filteredData[indexPath.row].id!) {
            cell.favoriteButtonOutlet.setImage(UIImage(named: "Favorite2"), for: UIControlState.normal)
        } else {
            cell.favoriteButtonOutlet.setImage(UIImage(named: "Favorite1"), for: UIControlState.normal)
        }
        
        cell.firstNameLabel.text = filteredData[indexPath.row].firstName
        cell.lastNameLabel.text = filteredData[indexPath.row].lastName
        cell.placeOfWorkLabel.text = filteredData[indexPath.row].placeOfWork
        cell.positionLabel.text = filteredData[indexPath.row].position
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pdfScene =  segue.destination as? PdfViewController,
            let indexPath = tableView?.indexPath(for: (((sender as AnyObject).superview??.superview) as! UITableViewCell)){
            
            let selectedVehicle = filteredData[indexPath.row]
            pdfScene.pdfURL = selectedVehicle.linkPdf!
        }
        
        if let notesScene =  segue.destination as? NotesViewController{
            
            let selectedVehicle = filteredData[indexPathRow]
            notesScene.firstName = selectedVehicle.firstName!
            notesScene.lastName = selectedVehicle.lastName!
            notesScene.placeOfWork = selectedVehicle.placeOfWork!
            notesScene.pdfURL = selectedVehicle.linkPdf!
            notesScene.id = selectedVehicle.id!
            notesScene.position = selectedVehicle.position!
            print(selectedVehicle)
            
        }
    }
    
    
}
