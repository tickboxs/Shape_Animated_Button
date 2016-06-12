//
//  ViewController.swift
//  shape_animated_button
//
//  Created by 蔡磊 on 16/6/12.
//  Copyright © 2016年 cailei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let hiFiveButton = CLHiFiveButton { 
            
        }
        
        view.addSubview(hiFiveButton)
        let centerX = view.bounds.width*0.5
        let centerY = view.bounds.height*0.5
        
        hiFiveButton.center = CGPoint(x: centerX, y: centerY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

