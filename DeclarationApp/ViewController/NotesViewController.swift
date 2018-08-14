//
//  NotesViewController.swift
//  DeclarationApp
//
//  Created by vika on 8/13/18.
//  Copyright © 2018 vika. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var noteView: UIView!
    
    var pdfURL = String()
    var firstName = String()
    var lastName = String()
    var placeOfWork = String()
    var position = String()
    var id = String()
    var note = String()
    var declaration:[FavoriteData] = []
    let workingCoreData = WorkingCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteView.layer.cornerRadius = 20
        noteView.layer.shadowOffset = CGSize(width: 3, height: 3)
        noteView.layer.shadowOpacity = 0.9
        noteView.layer.shadowRadius = 6.0
        
        notesTextView.tintColor = .darkGray
        let newPosition = notesTextView.beginningOfDocument
        notesTextView.selectedTextRange = notesTextView.textRange(from: newPosition, to: newPosition)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if workingCoreData.someEntityExists(id: id){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteData")
            let predicateID = NSPredicate(format: "id == %@", id)
            fetchRequest.predicate = predicateID
            
            var results: [NSManagedObject] = []
            do {
                results = try AppDelegate.getContext().fetch(fetchRequest) as! [NSManagedObject]
                if results.count != 0 {
                    
                    results[0].setValue(notesTextView.text, forKey: "note")
                }
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            
        } else {
        
            let SaveDeclarationClass:String = String(describing: FavoriteData.self)
            let saveData:FavoriteData = NSEntityDescription.insertNewObject(forEntityName: SaveDeclarationClass, into: AppDelegate.getContext()) as! FavoriteData
        
            saveData.firstName = firstName
            saveData.lastName = lastName
            saveData.linkPdf = pdfURL
            saveData.placeOfWork = placeOfWork
            saveData.note = notesTextView.text
            saveData.id = id
            saveData.position = position
        }
        AppDelegate.saveContext()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func canselButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
   
}
