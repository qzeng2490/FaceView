//
//  BlinkViewController.swift
//  FaceIt
//
//  Created by Zeng Qiang on 6/28/16.
//  Copyright © 2016 Zeng Qiang. All rights reserved.
//

import UIKit

class BlinkViewController: FaceViewController {

    var blinking: Bool = false {
        didSet {
            startBlink()
        }
    }
    private struct BlinkRate {
        static let ClosedDuration = 0.4
        static let OpenDuration = 2.5
    }
    
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            // afer a moment
            NSTimer.scheduledTimerWithTimeInterval(BlinkRate.ClosedDuration,
                                                   target: self,
                                                   selector: #selector(BlinkViewController.endBlink),
                                                   userInfo: nil,
                                                   repeats: false
            )
        }
    }
    
    func endBlink(timer: NSTimer) {
        faceView.eyesOpen = true
        NSTimer.scheduledTimerWithTimeInterval(BlinkRate.OpenDuration,
                                               target: self,
                                               selector: #selector(BlinkViewController.startBlink),
                                               userInfo: nil,
                                               repeats: false
        )
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        blinking = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
}
