//
//  CLHiFiveButton.swift
//  tetsadadsa
//
//  Created by 蔡磊 on 16/6/6.
//  Copyright © 2016年 bjzjns. All rights reserved.
//

import UIKit

class CLHiFiveButton: UIView {
    
    //MARK:lazy load
    lazy var imageView = UIImageView()
    lazy var titleLabel = UILabel()
    
    lazy var backgroundColorLayer = CAShapeLayer()
    
    //状态标识
    private var isPopped = true
    
    //timer
    var timer:NSTimer?
    
    //点击事件回调
    var tapCallback:(()->Void)?
    
    //MARK:init
    init(TapCallback tapCallback:(()->Void)) {
       super.init(frame: CGRectZero)
        
        self.tapCallback = tapCallback
        
        prepareView()
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:UI
    private func prepareView() -> Void{
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.bounds = CGRect(x: 0, y: 0, width: 120, height: 50)
        
        //点击事件
//        let tapGesture = UITapGestureRecognizer { (tapGesture) in
//            self.tapCallback!()
//        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() -> Void{
        layer.addSublayer(backgroundColorLayer)
        addSubview(imageView)
        addSubview(titleLabel)
        layer.animationKeys()
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25)
        backgroundColorLayer.path = path.CGPath
        backgroundColorLayer.fillColor = UIColor.redColor().CGColor
        
        imageView.frame = CGRect(x:13.5 , y: 13, width: 23, height: 24)
        imageView.image = UIImage(named: "Publish_hiFive")!.imageWithRenderingMode(.AlwaysTemplate)
        imageView.tintColor = UIColor.whiteColor()
        
        titleLabel.text = "我需要"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.frame = CGRect(x: 50, y: 0, width: 100, height: 50)
        
        //开始循环动画
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(repeatAnimation), userInfo: nil, repeats: true)
  
    }
    
    //MARK:animation
    //放大动画
    func pop() -> Void{
        //如果有动画进行 则直接返回
        if layer.animationKeys() != nil{
            return
        }
        
        //保存旧frame 计算新frame
        let originalFrame = self.frame
        let newFrame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y-5, width: 120, height: 50)
        
        UIView.animateWithDuration(0.25, animations: {
            //imageView 颜色变成白色
            self.imageView.tintColor = UIColor.whiteColor()
            //view frame 放大
            self.frame = newFrame

            //调整imageView位置
            self.imageView.frame = CGRect(x:13.5 , y: 13, width: 23, height: 24)
            //调整titleLabel位置和alpha
            self.titleLabel.frame = CGRect(x: 50, y: 0, width: 100, height: 50)
            self.titleLabel.alpha = 1
            
            
        }) { (stop) in
            self.layer.cornerRadius = 25
        }
        
        //backgroundColorLayer 放大动画
        let shrinkAnimation = CABasicAnimation(keyPath: "path")
        shrinkAnimation.duration = 0.25
        shrinkAnimation.toValue = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: newFrame.width, height: newFrame.height), cornerRadius: 25).CGPath
        shrinkAnimation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionEaseOut)
        shrinkAnimation.removedOnCompletion = false
        shrinkAnimation.fillMode = kCAFillModeForwards
        backgroundColorLayer.addAnimation(shrinkAnimation, forKey: nil)
        
        //backgroundColorLayer 颜色变红
        let colorAnimation = CABasicAnimation(keyPath: "fillColor")
        colorAnimation.duration = 0.25
        colorAnimation.toValue = UIColor.redColor().CGColor
        colorAnimation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionEaseOut)
        colorAnimation.removedOnCompletion = false
        colorAnimation.fillMode = kCAFillModeForwards
        backgroundColorLayer.addAnimation(colorAnimation, forKey: "colorAnimation")
    }
    
    //缩小动画
    func shrink() -> Void{
        //如果有动画进行 则直接返回
        if layer.animationKeys() != nil{
            return
        }
        
        //保存旧frame 计算新frame
        let originalFrame = self.frame
        let newFrame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y+5, width: 40, height: 40)
        
        UIView.animateWithDuration(0.25, animations: {
            //imageView 颜色变成黑色
            self.imageView.tintColor = UIColor.blackColor()
            //view frame 缩小
            self.frame = newFrame
            self.layer.cornerRadius = 20
            //调整imageView位置
            self.imageView.frame = CGRect(x: 11, y: 10.5, width: 18, height: 19)
            //调整titleLabel位置和alpha
            self.titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            self.titleLabel.alpha = 0
            
            
            }) { (stop) in
                
        }
        
        //backgroundColorLayer 缩小动画
        let shrinkAnimation = CABasicAnimation(keyPath: "path")
        shrinkAnimation.duration = 0.25
        shrinkAnimation.toValue = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 40, height: 40), cornerRadius: 20).CGPath
        shrinkAnimation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionEaseOut)
        shrinkAnimation.removedOnCompletion = false
        shrinkAnimation.fillMode = kCAFillModeForwards
        backgroundColorLayer.addAnimation(shrinkAnimation, forKey: nil)
        
        //backgroundColorLayer 颜色变白
        let colorAnimation = CABasicAnimation(keyPath: "fillColor")
        colorAnimation.duration = 0.25
        colorAnimation.toValue = UIColor.whiteColor().CGColor
        colorAnimation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionEaseOut)
        colorAnimation.removedOnCompletion = false
        colorAnimation.fillMode = kCAFillModeForwards
        backgroundColorLayer.addAnimation(colorAnimation, forKey: "colorAnimation")
        
    }
    
    //开启循环动画
    func startRepeatAnimation() -> Void{
        self.timer?.fireDate = NSDate.distantPast()
    }
    
    //关闭循环动画
    func stopRepeatAnimation() -> Void{
        self.timer?.fireDate = NSDate.distantFuture()
    }
    
    func tap() -> Void{
        self.tapCallback!()
    }
    
    func repeatAnimation() -> Void{
        //循环pop shrink动画
        if self.isPopped == true{
            self.shrink()
        }else{
            self.pop()
        }
        
        self.isPopped = !self.isPopped
    }
    
}
