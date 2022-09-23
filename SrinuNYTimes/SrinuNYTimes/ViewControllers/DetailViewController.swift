//
//  DetailViewController.swift
//  NY Times
//
//  Created by Srinu K on 23/09/23.
//

import UIKit
import WebKit
class DetailViewController: UIViewController, WKNavigationDelegate{
var nyURL = ""
    var webView: WKWebView!
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
     
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async() {
        Helper().showActivityIndicator(uiView: self.view)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: nyURL) {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.sizeToFit()
        }
    }
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async() {
       Helper().hideActivityIndicator(uiView: self.view)
        print("loaded")
        }
    }
}
