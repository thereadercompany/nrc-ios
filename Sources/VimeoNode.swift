//
//  VimeoNode.swift
//  NRC
//
//  Created by Taco Vollmer on 14/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import WebKit

class VimeoNode: StreamingVideoNode<StreamingVideoContent>, WKNavigationDelegate {
    lazy var webView: WKWebView = { [unowned self] in
        let configuration = WKWebViewConfiguration()
        configuration.requiresUserActionForMediaPlayback = false
        configuration.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: self.bounds, configuration: configuration)
        view.navigationDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()
    
    //MARK - View animation
    override var videoView: UIView {
        return webView
    }
    
    //MARK: - Initialization
    required init(content: StreamingVideoContent) {
        super.init(content: content)
    }
    
    //MARK: - Transport
    override func play() {
        showVideoView()
        guard let fullPath = NSBundle.mainBundle().pathForResource("vimeo", ofType: "html") else { return }
        do {
            let rawHtml = try NSString(contentsOfFile: fullPath, encoding: NSUTF8StringEncoding)
            let html = NSString(format: rawHtml, content.video.identifier)
            self.webView.loadHTMLString(String(html), baseURL: NSURL(string:"https://player.vimeo.com"))
        }
        catch {
            // this will never occur
        }
    }
    
    override func pause() {
        webView.evaluateJavaScript("pause()", completionHandler: nil)
    }
}
