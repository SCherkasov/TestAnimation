//
//  ViewController.swift
//  TestAnimation
//
//  Created by Stanislav Cherkasov on 23.07.2018.
//  Copyright © 2018 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageWithAnimation: UIImageView!
  
    var imageViews: [UIImageView] = []
    
    var leftImageView: UIImageView {
        return self.imageViews[0]
    }
    
    var rightImageView: UIImageView {
        return self.imageViews[1]
    }
    
    enum DoorState {
        case opened
        case closed
    }

    var doorSate = DoorState.closed

    @IBOutlet weak var welcomeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageViews = UIImage(named: "1")!.divideIntoTwoVertialParts()
            .map {
                UIImageView.init(image: $0)
            }
        
        let width = self.imageWithAnimation.frame.width
        imageViews[0].frame = CGRect.init(
            x: 0,
            y: 0,
            width: width / 2.0,
            height: width
        )
        
        imageViews[1].frame = CGRect.init(
            x: width / 2.0,
            y: 0,
            width: width / 2.0,
            height: width
        )
        
        imageViews[0].alpha = 0.5
        imageViews[1].alpha = 0.5
        
        imageViews[0].layer.zPosition = 500
        imageViews[1].layer.zPosition = 500
        self.welcomeView.layer.zPosition = -500
        
        self.welcomeView.addSubview(imageViews[0])
        self.welcomeView.addSubview(imageViews[1])

        print("\(self.imageWithAnimation.frame)")
    }
    
    override func viewDidLayoutSubviews() {
        print("\(self.imageWithAnimation.frame)")
    }

    @IBAction func goButton(_ sender: UIButton) {
        switch self.doorSate {
        case .opened:
            self.doorSate = .closed
            self.transition(to: .closed)
        case .closed:
            self.doorSate = .opened
            self.transition(to: .opened)
        }
    }
  
    func showAnimation() {
        let width = self.imageWithAnimation.frame.width
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: [.beginFromCurrentState, .curveEaseOut],
            animations: {
                self.imageViews[0].frame = CGRect.init(
                    x: -width / 2.0,
                    y: 0,
                    width: width / 2.0,
                    height: width
                )
            },
            completion: nil
        )
    }
    
    enum Edge {
        case left
        case right
    }
    
    func rotateAnimation(
        for imageView: UIImageView,
        aroundEdge edge: Edge,
        by degrees: Double,
        duration: Double) ->  CABasicAnimation
    {
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / 500.0;
        transform = CATransform3DRotate(
            transform,
            CGFloat(degrees * .pi / 180),
            0,
            1,
            0
        )
        
        switch edge {
        case .right:
            self.set(
                anchorPoint: CGPoint(x: 1.0, y: 0.5),
                forView: imageView
            )
        case .left:
            self.set(
                anchorPoint: CGPoint(x: 0.0, y: 0.5),
                forView: imageView
            )
        }
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.toValue = NSValue.init(caTransform3D:transform)
        animation.duration = duration
        
        animation.fillMode = kCAFillModeForwards;
        //animation.isRemovedOnCompletion = false;
        
        return animation
    }
    
    func transition(to nextDoorState: DoorState) {
        if nextDoorState == .opened {
            
            CATransaction.setCompletionBlock {
                let pRect = self.welcomeView.frame
                
                let rect = CGRect.init(
                    x: -pRect.width / 2.0,
                    y: 0,
                    width: pRect.width / 2.0,
                    height: pRect.height
                )
                
                self.leftImageView.frame = rect
                
                let sourceImage = self.leftImageView.image!.cgImage!
                
                self.leftImageView.image = UIImage.init(
                    cgImage: sourceImage,
                    scale: self.leftImageView.image!.scale,
                    orientation: UIImageOrientation.upMirrored
                )
            }
            
            CATransaction.begin()
           
            let animation = self.rotateAnimation(
                for: self.leftImageView,
                aroundEdge: .left,
                by: -180,
                duration: 1
            )
            
            self.leftImageView.layer.add(animation, forKey: "transform")
            
            CATransaction.commit()
        
        } else {
            CATransaction.setCompletionBlock {
                let pRect = self.welcomeView.frame
                
                let rect = CGRect.init(
                    x: 0,
                    y: 0,
                    width: pRect.width / 2.0,
                    height: pRect.height
                )
                
                self.leftImageView.frame = rect
                
                let sourceImage = self.leftImageView.image!.cgImage!
                
                self.leftImageView.image = UIImage.init(
                    cgImage: sourceImage
                )
            }
            
            CATransaction.begin()
            
             let animation = self.rotateAnimation(
                for: self.leftImageView,
                aroundEdge: .right,
                by: -180,
                duration: 1
            )
            
            self.leftImageView.layer.add(animation, forKey: "transform")
            
            CATransaction.commit()
        }
    }
    
    func set(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint.init(
            x: view.bounds.size.width * anchorPoint.x,
            y: view.bounds.size.height * anchorPoint.y
        )
        var oldPoint = CGPoint.init(
            x: view.bounds.size.width * view.layer.anchorPoint.x,
            y: view.bounds.size.height * view.layer.anchorPoint.y
        )
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }

    func hideAnimation() {
        let width = self.imageWithAnimation.frame.width
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: [.beginFromCurrentState, .curveEaseOut],
            animations: {
                self.imageViews[0].frame = CGRect.init(
                    x: 0,
                    y: 0,
                    width: width / 2.0,
                    height: width
                )
            },
            completion: nil
        )
    }
}
