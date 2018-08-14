//
//  Constant.swift
//  DeclarationApp
//
//  Created by vika on 8/11/18.
//  Copyright © 2018 vika. All rights reserved.
//

import Foundation

class Constants{
    
    static let declarationUrl = "https://public-api.nazk.gov.ua/v1/declaration/"
    static let errorJSON = "Error serializing json"
    static let errorValue = "Error invalid value"
    
}

struct Declaration: Codable{
    let page: Page
    let items: [Items]
}

struct Page: Codable {
    let batchSize: Int
}

struct Items: Codable{
    
    let id: String?
    let position: String?
    let firstName: String?
    let lastName: String?
    let placeOfWork: String?
    let linkPdf: String?
    
    private enum CodingKeys : String, CodingKey {
        case id
        case position
        case firstName = "firstname"
        case lastName = "lastname"
        case placeOfWork
        case linkPdf = "linkPDF"
    }
}

struct DeclarationData{
    
    let id: String?
    let position: String?
    let firstName: String?
    let lastName: String?
    let placeOfWork: String?
    let linkPdf: String?
    
}

struct FilteredData {
    
    let id: String?
    let position: String?
    let firstName: String?
    let lastName: String?
    let placeOfWork: String?
    let linkPdf: String?
    
}
