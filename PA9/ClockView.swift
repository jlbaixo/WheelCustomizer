//
//  ClockView.swift
//  PA9
//
//  Created by student on 3/16/16.
//  Copyright © 2016 JLB. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    // Fundamental elements
    var clockRadius: CGFloat!
    var clockCenterPoint: CGPoint!
    var clockPath: UIBezierPath!
    
    // Time intervals
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    
    // Clock part measurements
    var clockBezelWidth: CGFloat!
    var minuteHandLength: CGFloat!
    var hourHandLength: CGFloat!
    
    // Clock part colors
    let clockRimColor = UIColor.blackColor()
    let clockFaceColor = UIColor.whiteColor()
    let secondHandColor: UIColor = UIColor.redColor()
    let minuteHandColor: UIColor = UIColor.greenColor()
    let hourHandColor: UIColor = UIColor.blueColor()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        clockCenterPoint = CGPoint(
            x: (self.bounds.width / 2),
            y: (self.bounds.height / 2)
        )
        
        clockBezelWidth = 2.5
        
        if self.bounds.height > self.bounds.width {
            clockRadius = CGFloat((self.bounds.width / 2) - clockBezelWidth)
        } else {
            clockRadius = CGFloat((self.bounds.height / 2) - clockBezelWidth)
        }
        
        clockPath = UIBezierPath(
            arcCenter: clockCenterPoint,
            radius: clockRadius,
            startAngle: 0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: true
        )
        
        clockPath.lineWidth = clockBezelWidth
        
        minuteHandLength = clockRadius * (2/3)
        hourHandLength = clockRadius * (1/2)
    }
    
    
    func incrementByOneSecond() {
        seconds++
        
        hours += (minutes / 60)
        minutes += (seconds / 60)
        seconds %= 60
        
        setNeedsDisplay()
    }

    
    override func drawRect(rect: CGRect) {
        // Draw the outside of the clock
        clockRimColor.setStroke()
        clockPath.stroke()
        
        // Fill in the face color
        clockFaceColor.setFill()
        clockPath.fill()
        
        clockPath.closePath()
        
        // Draw second hand
        drawHands(seconds, handLength: clockRadius, handColor: secondHandColor)
        // Draw minute hand
        drawHands(minutes, handLength: minuteHandLength, handColor: minuteHandColor)
        // Draw hour hand
        drawHands(hours, handLength: hourHandLength, handColor: hourHandColor)
    }
    
    func drawHands(timeInterval: Int, handLength: CGFloat, handColor: UIColor) {
        let handLength: CGFloat = handLength
        
        let handPath = UIBezierPath(
            arcCenter: clockCenterPoint,
            radius: clockRadius,
            startAngle: 0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: true
        )
        
        handPath.moveToPoint(clockCenterPoint)
        handPath.lineWidth = clockBezelWidth
        
        handPath.addLineToPoint(CGPoint(
            x: Double(clockCenterPoint.x) - Double(handLength) * cos(M_PI_2 + (Double(timeInterval) * 2 * M_PI / 60)),
            y: Double(clockCenterPoint.y) - Double(handLength) * sin(M_PI_2 + (Double(timeInterval) * 2 * M_PI / 60))
            ))

        handColor.setStroke()
        handPath.stroke()
        
        handPath.closePath()
    }
}
