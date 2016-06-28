//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Zeng Qiang on 6/13/16.
//  Copyright © 2016 Zeng Qiang. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionFaces: Dictionary<String, FacialExpression> = [
        "sad" : FacialExpression(eye: .Close, mouth: .Frown),
        "normal" : FacialExpression(eye: .Open, mouth: .Neutral),
        "happy" : FacialExpression(eye: .Open, mouth: .Smile)
    ]
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destunationvc = segue.destinationViewController
        if let navcon = destunationvc as? UINavigationController {
            destunationvc = navcon.visibleViewController ?? destunationvc
        }
        if let facevc = destunationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionFaces[identifier] {
                    facevc.expression = expression
                    if let sendingButton = sender as? UIButton {
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }
}
