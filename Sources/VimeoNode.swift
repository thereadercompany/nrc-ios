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

/** Content for VideoNode */
class StreamingVideoContent: Content {
    let identifier: String
    let overlayContent: VideoOverlayNodeContent
    
    init(identifier: String, overlayContent: VideoOverlayNodeContent, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.identifier = identifier
        self.overlayContent = overlayContent
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class VimeoNode: ContentNode<StreamingVideoContent>, VideoPlayer, VisibilityObserver, WKNavigationDelegate {
    let videoOverlayNode: VideoOverlayNode
    
    lazy var webView: WKWebView = { [unowned self] in
        let configuration = WKWebViewConfiguration()
        configuration.requiresUserActionForMediaPlayback = false
        configuration.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: self.bounds, configuration: configuration)
        view.navigationDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()
    
    
    //MARK: - Init
    required init(content: StreamingVideoContent) {
        videoOverlayNode = VideoOverlayNode(content: content.overlayContent)
        super.init(content: content)
        
        //overlay
        addSubnode(videoOverlayNode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStaticLayoutSpec(children: [videoOverlayNode])
    }
    
    //MARK: - Highlight
    override func highlight(highlighted: Bool, animated: Bool = true) {
        videoOverlayNode.highlightPlayButton(highlighted)
    }
    
    //MARK: - Interaction
    override func handleTap() {
        //TODO: check for internet connection
        play()
    }
    
    //MARK: - VideoPlayer
    var overlayNode: ASDisplayNode? {
        return videoOverlayNode
    }
    
    var playing: Bool {
        /** vimeo only plays fullscreen so cannot be playing when becoming partly invisible */
        return false
    }

    func play() {
        if webView.superview == nil {
            view.insertSubview(webView, atIndex: 0)
        }
        
        showOverlay(false, animationDuration: 1)

        guard let fullPath = NSBundle.mainBundle().pathForResource("vimeo", ofType: "html") else { return }
        do {
            let rawHtml = try NSString(contentsOfFile: fullPath, encoding: NSUTF8StringEncoding)
            let html = NSString(format: rawHtml, content.identifier)
            self.webView.loadHTMLString(String(html), baseURL: NSURL(string:"https://player.vimeo.com"))
        }
        catch {
            // this will never occur
        }
    }
    
    func pause() {
        webView.evaluateJavaScript("pause()", completionHandler: nil)
    }
}
