//
//  CurriculumViewController.swift
//  malone-swift-app
//
//  Created by Kyleigh Murray on 4/10/22.
//

import UIKit
import WebKit
import PDFKit

class PDFTableCell: UITableViewCell {
    
    @IBOutlet weak var preview: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    var documentInCell: PDFDocument?
}


class CurriculumViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Curriculum"
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
                let CurriculumDocumentViewController = segue.destination as? CurriculumDocumentViewController,
                let selectedCell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as? PDFTableCell
                else {
                    return
            }

            
        CurriculumDocumentViewController.document = selectedCell.documentInCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let path = Bundle.main.resourcePath!
        
        let enumerator = FileManager.default.enumerator(atPath: path)
        let filePaths = enumerator?.allObjects as! [String]
        let txtFilePaths = filePaths.filter{$0.contains(".pdf")}
        return txtFilePaths.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let path = Bundle.main.resourcePath!
        
        let enumerator = FileManager.default.enumerator(atPath: path)
        let filePaths = enumerator?.allObjects as! [String]
        let txtFilePaths = filePaths.filter{$0.contains(".pdf")}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PDFCell", for: indexPath) as! PDFTableCell
        
        let url = URL(fileURLWithPath: path + "/" + txtFilePaths[indexPath.row])
        let document = PDFDocument(url: url)
        cell.documentInCell = document
        let page = document!.page(at: 0)
        let pageRect = page!.bounds(for: .mediaBox)

        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            // Set and fill the background color.
            UIColor.white.set()
            ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))

            // Translate the context so that we only draw the `cropRect`.
            ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)

            // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            // Draw the PDF page.
            page!.draw(with: .mediaBox, to: ctx.cgContext)
        }

        cell.title.text = String(txtFilePaths[indexPath.row].dropLast(4))
        cell.preview.layer.cornerRadius = 5.0
        cell.preview.layer.masksToBounds = true
        cell.preview.contentMode = .scaleAspectFill
        cell.preview.image = img
        cell.title.lineBreakMode = .byWordWrapping
        

            return cell
    }
    
    
}
