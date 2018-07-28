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

    var isOpened = false

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
        imageViews[0].alpha = 0.5
        
        self.welcomeView.addSubview(imageViews[0])
        self.welcomeView.addSubview(imageViews[1])

        print("\(self.imageWithAnimation.frame)")
    }
    
    override func viewDidLayoutSubviews() {
        print("\(self.imageWithAnimation.frame)")
    }

    @IBAction func goButton(_ sender: UIButton) {
        self.isOpened = !self.isOpened
        
        if self.isOpened {
            self.showAnimation()
        } else {
            self.hideAnimation()
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
