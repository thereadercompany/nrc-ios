//
//  TimelineNavigationViewController.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/09/15.
//

import Foundation

class TimelineNavigationViewController: NavigationViewController<TimelineNavigationView> {
    override class var defaultStyle: NavigationViewStyle {
        return TimelineStyles.navigationViewStyle
    }
    
    //MARK - initilalization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK - titles
    
    func setTitle(title: String?, subtitle: String?, animated: Bool) {
    }
    
    //MARK: - buttons
    
    func configureAccountButton(target target: AnyObject, action: Selector) {
    }

    func configureLoginButton(target target: AnyObject, action: Selector) {
    }
    
    func updateLoginState(loggedIn: Bool) {
    }
        
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return TimelineStyles.preferredStatusBarStyle(navigationView.style)
    }
}
