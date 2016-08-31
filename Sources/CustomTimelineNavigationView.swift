//
//  TimelineNavigationView.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/09/15.
//

import UIKit
import Core

class CustomTimelineNavigationView: TimelineNavigationView {
    // images
    private let logo = UIImage(named: "nrc-nl-logo-small")!
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.navigationViewDividerColor
        return view
    }()


    let searchButton = UIButton(type: .Custom)
    
    required init(style: NavigationViewStyle) {
        // views
        let logoView = UIImageView(image: logo)
        logoView.contentMode = .ScaleAspectFit

        let accountButton = UIButton(type: .Custom)
        let accountImage = UIImage(named: "account-icon-dark")!
        accountButton.setImage(accountImage, forState: .Normal)
        accountButton.hidden = true
        
        let loginButton = LoginButton(title: "LOG IN")
        
        super.init(style: style, logoView: logoView, accountButton: accountButton, loginButton: loginButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(logoView)
        addSubview(accountButton!)
        addSubview(loginButton!)
        addSubview(searchButton)
        addSubview(dividerView)
    }
    
    override func setupConstrains() {
        super.setupConstrains()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerYAnchor.constraintEqualToAnchor(topAnchor, constant: 40).active = true
        logoView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        logoView.heightAnchor.constraintEqualToConstant(18).active = true
        logoView.widthAnchor.constraintEqualToAnchor(logoView.heightAnchor, multiplier: logo.size.width / logo.size.height).active = true
        
        let halfStatusbarHeight: CGFloat = 10
        let buttonSize = CGSize(width: 44, height: 44)
        
        // search
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: halfStatusbarHeight).active = true
        searchButton.widthAnchor.constraintEqualToConstant(buttonSize.height).active = true
        searchButton.heightAnchor.constraintEqualToConstant(buttonSize.width).active = true
        searchButton.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        
        // login
        loginButton?.translatesAutoresizingMaskIntoConstraints = false
        loginButton?.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: halfStatusbarHeight).active = true
        loginButton?.heightAnchor.constraintEqualToConstant(buttonSize.height).active = true
        loginButton?.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -16).active = true
        
        // account
        accountButton?.translatesAutoresizingMaskIntoConstraints = false
        accountButton?.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: halfStatusbarHeight).active = true
        accountButton?.widthAnchor.constraintEqualToConstant(buttonSize.width).active = true
        accountButton?.heightAnchor.constraintEqualToConstant(buttonSize.height).active = true
        accountButton?.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -6).active = true
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.topAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        dividerView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        dividerView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        dividerView.heightAnchor.constraintEqualToConstant(0.5).active = true
    }

    override func updateAccountButton() {
        let loggedIn = User.current.isLoggedIn
        loginButton?.hidden = loggedIn
        accountButton?.hidden = !loggedIn
    }
}
