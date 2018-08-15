//
//  ViewController.swift
//  DeclarationApp
//
//  Created by vika on 8/12/18.
//  Copyright © 2018 vika. All rights reserved.
//

import UIKit
import PDFKit

class PdfViewController: UIViewController {

    @IBOutlet var pdfView: PDFView!
    @IBOutlet weak var noValueLabel: UILabel!
    var pdfURL = String()
    var pdfDOC: PDFDocument!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.backgroundColor = .white
        
        if CheckInternet.Connection(){
            if pdfURL != " " {
                downloadPDF()
            } else {
                noValueLabel.textColor = UIColor.darkGray
                noValueLabel.text = "PDF is missing"
                self.pdfView.addSubview(noValueLabel)
            }
        }
    }

    func downloadPDF(){
        
        print(pdfURL)
        
        guard let url = URL(string: pdfURL) else {return}
        do{
            let data = try Data(contentsOf: url)
            pdfDOC = PDFDocument(data: data)
            pdfView.displayMode = .singlePageContinuous
            //pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pdfView.displaysAsBook = true
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDOC
            pdfView.autoScales = true
            pdfView.maxScaleFactor = 4.0
            pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
    
        }catch let err{
            print(Constants.errorJSON)
        }
    }
    
   
    
}
