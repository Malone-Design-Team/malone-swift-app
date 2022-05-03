//
//  CurriculumDocumentViewController.swift
//  malone-swift-app
//
//  Created by Carter Brehm on 5/3/22.
//

import UIKit
import PDFKit

class CurriculumDocumentViewController: UIViewController {

    var document: PDFDocument?
    
    var pdfView: PDFView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        pdfView = PDFView()
        
        guard let pdfView = pdfView else {
            return
        }


        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.navigationItem.title = "Document"
        self.tabBarController?.tabBar.isHidden = true
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard let pdfView = pdfView else {
            return
        }

        
        if let document = document {
            pdfView.document = document
        }
        
        pdfView.maxScaleFactor = 4.0;
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit;
        pdfView.autoScales = true;
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
