//
//  ViewController.swift
//  FaceIt
//
//  Created by Zeng Qiang on 6/11/16.
//  Copyright © 2016 Zeng Qiang. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eye:.Open  ,mouth: .Frown) { didSet { updateUI() } }
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
            
            
            updateUI()
            
        }
    }
    
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            switch expression.eye {
            case .Close: expression.eye = .Open
            case .Open: expression.eye = .Close
            }
        }
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
        switch expression.eye {
        case .Open: faceView.eyesOpen = true
        case .Close: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    

}

