//
//  ColorView.swift
//  NextNewApp
//
//  Created by Пользователь on 19.06.15.
//  Copyright (c) 2015 mpei. All rights reserved.
//

import UIKit

enum Orientation:Int {
 case North=1, East=2, South=3, West=4, Full=0
}
@IBDesignable class ColorView: UIControl {

    @IBInspectable var fill: UIColor = UIColor.lightGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var orientFlag: Int = 0 {
        didSet{
            self.orientation = Orientation(rawValue: orientFlag)!
        }
    }
     var orientation = Orientation.Full {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var backgroundColor:UIColor? {
        didSet{
            if backgroundColor != UIColor.clearColor() {
                backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        // Drawing code
        fill.setFill()
        
        var path:UIBezierPath
        
        var center: CGPoint = rect.origin
        let radius = max(rect.width, rect.height)/2
        
        switch (orientation){
        case .North:
            center.x += rect.width/2
            
            if(rect.width == rect.height) {
                center.y += rect.height/2
            } else {
                center.y += rect.height
            }
            path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 3.1415, endAngle: 0.0, clockwise: true)
        
        case .South:
           center.x += rect.width/2
            if(rect.width == rect.height) {
                 center.y += rect.height/2
                
            }
            path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 3.1415, endAngle: 0.0, clockwise: false)
        case .East:
            center.y += rect.height/2
            if(rect.width == rect.height) {
                center.x += rect.width/2
            } else {
                center.x += rect.width
            }
            path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 3.1415/2, endAngle: -3.1415/2, clockwise: true)
        case .West:
            center.y += rect.height/2
            if(rect.width == rect.height) {
                center.x += rect.width/2
                
            }
            path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 3.1415/2, endAngle: -3.1415/2, clockwise: false)
            
        default:
            path = UIBezierPath(ovalInRect: rect)
        }
        
        path.fill()
        
    }

    

}
