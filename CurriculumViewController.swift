//
//  CurriculumViewController.swift
//  malone-swift-app
//
//  Created by Kyleigh Murray on 4/10/22.
//

import UIKit
import WebKit
import PDFKit


class CurriculumViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PDFCell", for: indexPath)

        cell.textLabel?.text = txtFilePaths[indexPath.row]
        cell.detailTextLabel?.text = "poop cock"
        

            return cell
    }
    
    
}
