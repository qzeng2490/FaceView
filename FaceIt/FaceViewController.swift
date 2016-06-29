//
//  ViewController.swift
//  FaceIt
//
//  Created by Zeng Qiang on 6/11/16.
//  Copyright © 2016 Zeng Qiang. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eye: .Open  ,mouth:.Frown) { didSet { updateUI() } }
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(
                UIPinchGestureRecognizer(
                    target: faceView,
                    action: #selector(FaceView.changeScale(_:))
                ))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                    target: self,
                    action: #selector(FaceViewController.increaseHappiness)
                )
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self,
                action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            // reason to updateUI ???
            updateUI()
            
        }
    }
    
    
//    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
//        if recognizer.state == .Ended {
//            switch expression.eye {
//            case .Close: expression.eye = .Open
//            case .Open: expression.eye = .Close
//            }
//        }
//    }
    
    private struct Animation {
        static let ShakeAngle = CGFloat(M_PI/6)
        static let ShakeDuration = 0.5
    }
    @IBAction func headShake(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(Animation.ShakeDuration,
                                   animations: {
                                        self.faceView.transform = CGAffineTransformRotate(self.faceView.transform, Animation.ShakeAngle)
                                    },
                                   completion: { finished in 
                                        if finished {
                                            UIView.animateWithDuration(Animation.ShakeDuration,
                                                animations: {
                                                    self.faceView.transform = CGAffineTransformRotate(self.faceView.transform, -Animation.ShakeAngle*2)
                                                },
                                                completion: { finished in
                                                    if finished {
                                                        UIView.animateWithDuration(Animation.ShakeDuration,
                                                            animations: {
                                                                self.faceView.transform = CGAffineTransformRotate(self.faceView.transform, Animation.ShakeAngle)
                                                            },
                                                            completion: { finished in
                                                                
                                                            }
                                                        )
                                                        
                                                    }
                                                }
                                            )
                                            
                                            
                                            
                                        }
                                   }
        )
    }
    
    func increaseHappiness()
    {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness()
    {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Neutral: 0.0, .Smile : 1.0]
    
    private func updateUI()
    {
        if(faceView != nil) {
            switch expression.eye {
            case .Open: faceView.eyesOpen = true
            case .Close: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        }
        
    }
    

}

