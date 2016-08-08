//
//  HTMLMenuViewController.swift
//  Pods
//
//  Created by Jeroen Vloothuis on 08-08-16.
//
//

import UIKit
import WebKit
import Core


public class HTMLMenuViewController: UIViewController {
    var webView: WKWebView!


    override public func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(HTMLMenuViewController.dismissMenu))

        webView = WKWebView(frame: view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.topAnchor.constraintEqualToAnchor(view.topAnchor)
        webView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        webView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        webView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)

        webView.loadRequest(NSURLRequest(URL: serverBaseURL().URLByAppendingPathComponent("__staticmenu__")))
    }


    func dismissMenu() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
