//
//  HomeTabViewController.swift
//  malone-swift-app
//
//  Created by Carter Brehm on 3/9/22.
//

import UIKit
import WebKit

class HomeTabViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    private var observation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        let request = URLRequest(url: URL(string: "https://malonecenter.org")!)
        webView.uiDelegate = self
        webView?.load(request)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frame = navigationAction.targetFrame,
            frame.isMainFrame {
            return nil
        }
        webView.load(navigationAction.request)
        return nil
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


