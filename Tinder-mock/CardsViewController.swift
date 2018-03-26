//
//  CardsViewController.swift
//  Tinder-mock
//
//  Created by Aayush  Gupta on 3/25/18.
//  Copyright © 2018 Aayush  Gupta. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardInitialCenter: CGPoint!
    var tapPointInitial: CGPoint!
    var tapPointFinal: CGPoint!
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        userImage.addGestureRecognizer(panGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    
    @objc func didPan(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        if sender.state == UIGestureRecognizerState.began{
            cardInitialCenter = userImage.center
            tapPointInitial = sender.location(in: view)
        }else if sender.state == UIGestureRecognizerState.changed{
            tapPointFinal = sender.location(in: view)
            var rotationAngle = getImageRotation(start: tapPointInitial, end: tapPointFinal, center: cardInitialCenter)
            if rotationAngle > Double.pi/6{
                // Avoid excessive rotation.
                rotationAngle = Double.pi/6
            }
            if translation.y > 0{
               userImage.center = CGPoint(x: cardInitialCenter.x + translation.x , y: cardInitialCenter.y + translation.y)
            }else{
               userImage.center = CGPoint(x: cardInitialCenter.x + translation.x , y: cardInitialCenter.y - translation.y)
            }
            if translation.x > 0{
             userImage.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
                if translation.x >= 50{
                    UIView.animate(withDuration: 0.3, animations: {
                        self.userImage.alpha = 0
                    })
                }
            }else{
                if translation.x <= -50{
                    if translation.x >= 50{
                        UIView.animate(withDuration: 0.3, animations: {
                            self.userImage.alpha = 0
                        })
                    }
                }
                userImage.transform = CGAffineTransform(rotationAngle: -CGFloat(rotationAngle))
            }
        }else if sender.state == UIGestureRecognizerState.ended{
            userImage.center = cardInitialCenter
            userImage.transform = CGAffineTransform.identity
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue"{
            let destination = segue.destination as! ProfileViewController
           destination.profileImageURL = "ryan"
        }
    }
    
    @IBAction func didTapProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImageRotation(start: CGPoint, end: CGPoint, center: CGPoint) -> Double{
        // print("Image Center: \(center) Start Point: \(start) End Point \(end)")
        let initialDistance = Double((pow(start.x - center.x, 2) + pow(start.y - center.y, 2)))
        // print(initialDistance)
        let finalDistance = Double((pow(end.x - center.x, 2) + pow(end.y - center.y, 2)))
        // print(finalDistance)
        let intermediateDistance = Double((pow(end.x - start.x, 2) + pow(end.y - start.y, 2)))
        // print(intermediateDistance)
        let rotationAngle = acos((initialDistance + finalDistance - intermediateDistance)/(2*sqrt(initialDistance)*sqrt(finalDistance)))
        // print("Rotation Angle: \(rotationAngle)")
        return rotationAngle
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
