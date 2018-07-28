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
  
  var images: [UIImage]!

 override func viewDidLoad() {
    super.viewDidLoad()
}
  
  @IBAction func goButton(_ sender: UIButton) {
    sender.tag += 1
    if sender.tag > 1 { sender.tag = 0 }
    
    switch sender.tag {
    case 1:
      simpleAnimation()
      print("act_1")
    default:
      reverseSimpleAnimation()
      print("act_2")
    }
  }
  
  func simpleAnimation() {
    self.images = (1...7).map { UIImage(named: String($0))! }
    imageWithAnimation.animationImages = images
    imageWithAnimation.animationDuration = 1.0
    imageWithAnimation.animationRepeatCount = 1
    imageWithAnimation.startAnimating()
    imageWithAnimation.image = images.last
  }
  
  func reverseSimpleAnimation() {
    self.images = (8...13).map { UIImage(named: String($0))! }
    imageWithAnimation.animationDuration = 1.0
    imageWithAnimation.animationRepeatCount = 1
    imageWithAnimation.startAnimating()
    imageWithAnimation.image = images.last
  }
}
