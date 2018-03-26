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
    var tapPoint: CGPoint!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        userImage.addGestureRecognizer(tapGestureRecognizer)
        userImage.addGestureRecognizer(panGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func didTap(sender: UITapGestureRecognizer){
        if sender.state == .recognized{
            print("Tap Recognized")
        }else if sender.state == .ended{
            print(sender.location(in: view))
        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        if sender.state == UIGestureRecognizerState.began{
            cardInitialCenter = userImage.center
        }else if sender.state == UIGestureRecognizerState.changed{
            // getImageRotation(start: CGPoint, end: <#T##CGPoint#>, center: cardInitialCenter)
            userImage.center = CGPoint(x: cardInitialCenter.x + translation.x , y: cardInitialCenter.y + translation.y)
            if translation.x > 0{
             userImage.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi/180))
            }else{
                userImage.transform = CGAffineTransform(rotationAngle: CGFloat(-45 * Double.pi/180))
            }
        }else if sender.state == UIGestureRecognizerState.ended{
            userImage.center = cardInitialCenter
            userImage.transform = CGAffineTransform.identity
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImageRotation(start: CGPoint, end: CGPoint, center: CGPoint){
        let initialDistance = Double((pow(start.x - center.x, 2) - pow(start.y - center.y, 2)))
        let finalDistance = Double((pow(end.x - center.x, 2) - pow(end.y - center.y, 2)))
        let intermediateDistance = Double((pow(end.x - start.x, 2) - pow(end.y - start.y, 2)))
        let rotationAngle = acos((initialDistance + finalDistance - intermediateDistance)/2*sqrt(initialDistance)*sqrt(finalDistance))
        print(rotationAngle)
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
