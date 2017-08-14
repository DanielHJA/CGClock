//
//  Clock.swift
//  CGClock
//
//  Created by Daniel Hjärtström on 2017-08-14.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Clock: UIView {
    
    var clockLayer: CAShapeLayer!
    var hourLayer: CAShapeLayer!
    var minuteLayer: CAShapeLayer!
    var secondLayer: CAShapeLayer!
    
    var clockStrokeColor: CGColor = UIColor.black.cgColor
    var hourStrokeColor: CGColor = UIColor.red.cgColor
    var minuteStrokeColor: CGColor = UIColor.orange.cgColor
    var secondStrokeColor: CGColor = UIColor.purple.cgColor
    var clearColor: CGColor = UIColor.clear.cgColor
    
    var startAngle: CGFloat = CGFloat(Double.pi * 3 / 2)
    var endAngle: CGFloat = CGFloat(CGFloat(Double.pi * 3 / 2) + CGFloat(4.0 * Double.pi / 2.0))
    
    var label: UILabel!
    
    var currentDate: Date!
    var timer: Timer!
    let formatter: DateFormatter = {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
        
    }()
    
    convenience init(rect: CGRect) {
        self.init(frame: rect)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawBase()
        drawLabel()
        drawHour()
        drawMinute()
        drawSecond()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateTime() {
    
        currentDate = Date()

        let hourStroke = Double(formatter.calendar.component(.hour, from: currentDate)) / 48.0 // Double 24 H clock
        let minuteStroke = Double(formatter.calendar.component(.minute, from: currentDate)) / 60.0
        let secondStroke = Double(formatter.calendar.component(.second, from: currentDate)) / 60.0
        
        hourLayer.strokeEnd = CGFloat(hourStroke)
        minuteLayer.strokeEnd = CGFloat(minuteStroke)
        secondLayer.strokeEnd = CGFloat(secondStroke)
        
        label.text = formatter.string(from: currentDate)

    }
    
    func drawBase() {
    
        let radius: CGFloat = frame.width / 2
        clockLayer = setuplayer(radius: radius, color: clockStrokeColor)
        clockLayer.strokeEnd = 1.0
        layer.addSublayer(clockLayer)
    }

    func drawLabel() {
    
        label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width / 5, height: self.frame.width / 5)
        label.center = self.center
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Helvetica", size: 17.0)
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.text = ""
        self.addSubview(label)
    }
    
    func drawHour() {

        let radius: CGFloat = frame.width / 6
        hourLayer = setuplayer(radius: radius, color: hourStrokeColor)
        layer.addSublayer(hourLayer)
    }
    
    func drawMinute() {
        
        let radius: CGFloat = frame.width / 3
        minuteLayer = setuplayer(radius: radius, color: minuteStrokeColor)
        layer.addSublayer(minuteLayer)
    }
    
    func drawSecond() {
    
        let radius: CGFloat = frame.width / 2.4
        secondLayer = setuplayer(radius: radius, color: secondStrokeColor)
        layer.addSublayer(secondLayer)
    }
    
    func setuplayer(radius: CGFloat, color: CGColor) -> CAShapeLayer {

        let secondPath = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let lLayer = CAShapeLayer()
        lLayer.frame = bounds
        lLayer.path = secondPath.cgPath
        lLayer.fillColor = clearColor
        lLayer.strokeColor = color
        lLayer.lineWidth = 9.0
        lLayer.lineCap = kCALineJoinRound
        lLayer.strokeStart = 0.0
        lLayer.strokeEnd = 0.0
    
        return lLayer
    }
}
