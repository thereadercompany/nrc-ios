//
//  TimelineNavigationViewController.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/09/15.
//

import Core
import UIKit

class CustomTimelineNavigationViewController: TimelineNavigationViewController {

    var timelineNavigationView: CustomTimelineNavigationView {
        return self.navigationView as! CustomTimelineNavigationView
    }
    
    override func transition(toStyle style: NavigationViewStyle, animated: Bool) {
        let navigationView = CustomTimelineNavigationView(style: style)
        self.transition(toView: navigationView, animated: animated)
    }

    //MARK - initialization

    init() {
        let navigationView = CustomTimelineNavigationView(style: TimelineStyles.navigationViewStyle)
        super.init(navigationView: navigationView, autoHideEnabled: TimelineStyles.navBarAutoHideEnabled)
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
