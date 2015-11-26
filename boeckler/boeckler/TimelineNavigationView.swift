//
//  TimelineNavigationView.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/09/15.
//

import Foundation

class TimelineNavigationView: NavigationView {
    // images
    let logo: UIImage
    
    // views
    let logoView: UIImageView
    
    required init(style: NavigationViewStyle) {
        // images
        logo = UIImage(named: "logo-navbar")!
        
        // views
        logoView = UIImageView(image: logo)
        logoView.contentMode = .ScaleAspectFit
        
        // labels
        super.init(style: style)
        
        needsLine = TimelineStyles.navigationViewNeedsLine(style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyStyle() {
        super.applyStyle()
    }

    override func addSubviews() {
        super.addSubviews()
        addSubview(logoView)
    }
    
    override func setupConstrains() {
        super.setupConstrains()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        logoView.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: 5).active = true
    }
}
