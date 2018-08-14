//
//  LoadData.swift
//  DeclarationApp
//
//  Created by vika on 8/11/18.
//  Copyright © 2018 vika. All rights reserved.
//

import Foundation

protocol Declarations{
    func returnData() -> [DeclarationData]
    func returnSize() -> Int
}

class LoadData: Declarations{
    
    // MARK: -
    // MARK: Parsing API
    
    var declarationData = [DeclarationData]()
    var batchSize = Int()
    
    // MARK: -
    // MARK: Decode declaration data
    
    func downloadData(URL_DATA: String, complection: @escaping () -> ()) {
        
        let url = URL(string: URL_DATA)
        
        URLSession.shared.dataTask(with: url!) { (data, tesponse, error) in
            
            guard let data = data else {return}
            
            do{
                
                let decode = try JSONDecoder().decode(Declaration.self, from: data)
                
                self.batchSize = decode.page.batchSize
                
                for i in 0..<decode.items.count{
                    
                    var firstName = String()
                    if decode.items[i].firstName != nil {
                        firstName = decode.items[i].firstName!
                    }else{
                        firstName = " "
                    }
                    
                    var lastName = String()
                    if decode.items[i].lastName != nil {
                        lastName = decode.items[i].lastName!
                    }else{
                        lastName = " "
                    }
                    
                    var placeOfWork = String()
                    if decode.items[i].placeOfWork != nil {
                        placeOfWork = decode.items[i].placeOfWork!
                    }else{
                        placeOfWork = " "
                    }
                    
                    var linkPdf = String()
                    if decode.items[i].linkPdf != nil {
                        linkPdf = decode.items[i].linkPdf!
                    }else{
                        linkPdf = " "
                    }
                    
                    var id = String()
                    if decode.items[i].id != nil {
                        id = decode.items[i].id!
                    }else{
                        id = " "
                    }
                    
                    var position = String()
                    if decode.items[i].position != nil {
                        position = decode.items[i].position!
                    }else{
                        position = " "
                    }
                    
                    self.declarationData.append(DeclarationData.init(id: id, position: position, firstName: firstName, lastName: lastName, placeOfWork: placeOfWork, linkPdf: linkPdf))
                    
                    DispatchQueue.main.async {
                        complection()
                    }
                    
                }
                
            } catch let jsonError {
                print(Constants.errorJSON, jsonError)
            }
            
            }.resume()
    }

    func returnData() -> [DeclarationData] {
        
        return declarationData
    }
    
    func returnSize() -> Int {
        
        return batchSize
    }
    
}
