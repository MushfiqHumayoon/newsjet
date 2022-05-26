//
//  WebViewController.swift
//  NewsApp
//
//  Created by Mushfiq Humayoon on 26/05/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
// MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
// MARK: - Vars & Lets
    var url: URL?
    var activityView: UIActivityIndicatorView?
// MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
// MARK: - Webkit Delegates
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        showActivityIndicatory()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityIndicator()
    }
// MARK: - Loader Setup
    private func showActivityIndicatory() {
        activityView = UIActivityIndicatorView(style: .large)
        if let activityView = activityView {
            activityView.center = self.view.center
            self.view.addSubview(activityView)
            activityView.startAnimating()
        }
    }
    private func hideActivityIndicator(){
        if let activityView = activityView {
            activityView.stopAnimating()
        }
    }
}
