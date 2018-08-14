//
//  ConvertData.swift
//  DeclarationApp
//
//  Created by vika on 8/12/18.
//  Copyright © 2018 vika. All rights reserved.
//

import Foundation

class ConvertData {
    
    var filteredData = [FilteredData]()
    
    func convertDataInArray(id: Int, declaration: [DeclarationData]) -> [String] {
        
        var array = [String]()
        
        switch id {
        case 1:
            for i in 0..<declaration.count{
                array.append(declaration[i].firstName!)
            }
        case 2:
            for i in 0..<declaration.count{
                array.append(declaration[i].lastName!)
            }
        case 3:
            for i in 0..<declaration.count{
                array.append(declaration[i].placeOfWork!)
            }
        case 4:
            for i in 0..<declaration.count{
                array.append(declaration[i].position!)
            }
        default:
            print(Constants.errorValue)
        }
        
        return array
    }
    
    func convertFilterdData(data: [String], declaration:[DeclarationData]) -> [FilteredData] {
        filteredData.removeAll()
        
        for j in 0..<data.count{
            for i in 0..<declaration.count{
                if declaration[i].firstName == data[j] || declaration[i].lastName == data[j] || declaration[i].placeOfWork == data[j] || declaration[i].position == data[j] {
                    self.filteredData.append(FilteredData.init(id: declaration[i].id, position: declaration[i].position, firstName: declaration[i].firstName, lastName: declaration[i].lastName, placeOfWork: declaration[i].placeOfWork, linkPdf: declaration[i].linkPdf))
                    break
                    }
                
                }
            }
        
        return filteredData
    }
    
    func createStruct(declaration:[DeclarationData]) -> [FilteredData] {
        filteredData.removeAll()
        
        for i in 0..<declaration.count{
            self.filteredData.append(FilteredData.init(id:  declaration[i].id, position:  declaration[i].position, firstName: declaration[i].firstName, lastName: declaration[i].lastName, placeOfWork: declaration[i].placeOfWork, linkPdf: declaration[i].linkPdf))
        }
       return filteredData
    }
        
}
