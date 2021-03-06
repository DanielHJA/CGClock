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

        clockLayer.addSublayer(hourLayer)
        clockLayer.addSublayer(minuteLayer)
        clockLayer.addSublayer(secondLayer)
        layer.addSublayer(clockLayer)

        setTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(validInvalidTimer), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(validInvalidTimer), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func validInvalidTimer() {
        
        if timer.isValid {
            timer.invalidate()
        } else {
            setTimer()
        }
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
    
        currentDate = Date()
        
        formatter.dateFormat = "hh:mm:ss"
        
        let minuteStroke = Double(formatter.calendar.component(.minute, from: currentDate)) / 60.0
        let secondStroke = Double(formatter.calendar.component(.second, from: currentDate)) / 60.0
        
        minuteLayer.strokeEnd = CGFloat(minuteStroke)
        secondLayer.strokeEnd = CGFloat(secondStroke)
        
        let hackyAMFormat = Int(formatter.string(from: currentDate).components(separatedBy: ":")[0])
        
        if let hourStroke = hackyAMFormat {

            hourLayer.strokeEnd = CGFloat(hourStroke) / 12.0
            
        }

        formatter.dateFormat = "HH:mm:ss"

        label.text = formatter.string(from: currentDate)
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
    
    func drawBase() {
        
        let radius: CGFloat = frame.width / 2
        clockLayer = setuplayer(radius: radius, color: clockStrokeColor)
        clockLayer.strokeEnd = 1.0
    }
    
    func drawHour() {

        let radius: CGFloat = frame.width / 6
        hourLayer = setuplayer(radius: radius, color: hourStrokeColor)
    }
    
    func drawMinute() {
        
        let radius: CGFloat = frame.width / 3
        minuteLayer = setuplayer(radius: radius, color: minuteStrokeColor)
    }
    
    func drawSecond() {
    
        let radius: CGFloat = frame.width / 2.4
        secondLayer = setuplayer(radius: radius, color: secondStrokeColor)
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
