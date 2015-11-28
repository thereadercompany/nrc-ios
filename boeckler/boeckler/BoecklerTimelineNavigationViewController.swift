//
//  TimelineNavigationViewController.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/09/15.
//

import Foundation

class BoecklerTimelineNavigationViewController: TimelineNavigationViewController {

    var timelineNavigationView: BoecklerTimelineNavigationView {
        return self.navigationView as! BoecklerTimelineNavigationView
    }
    
    override func transition(toStyle style: NavigationViewStyle, animated: Bool) {
        let navigationView = BoecklerTimelineNavigationView(style: style)
        self.transition(toView: navigationView, animated: animated)
    }
    
    //MARK - initialization

    init() {
        let navigationView = BoecklerTimelineNavigationView(style: TimelineStyles.navigationViewStyle)
        super.init(navigationView: navigationView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return TimelineStyles.preferredStatusBarStyle(navigationView.style)
    }
}
