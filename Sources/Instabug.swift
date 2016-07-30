//
//  Instabug.swift
//  ios-nrc-nl
//
//  Created by Niels van Hoorn on 21/09/15.
//  Copyright © 2015 NRC Media. All rights reserved.
//

import Foundation

extension Instabug {
    static func configureAndStart() {
        Instabug.startWithToken(AppConfig.instabugKey, invocationEvent: .Screenshot)
//        Instabug.setWillShowEmailField(UIApplication.isBeta)
//        Instabug.setIsTrackingCrashes(false)
//        Instabug.setWillShowStartAlert(false)
//        Instabug.setWillVibrateOnInvocation(false)
    }
}