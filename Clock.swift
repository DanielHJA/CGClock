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
    
    var clockFillColor: CGColor = UIColor.white.cgColor
    var clockStrokeColor: CGColor = UIColor.blue.cgColor
    
    let π = Double.pi
    
    var label: UILabel!
    
    var currentDate: Date!
    var timer: Timer?
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
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateTime() {
    
        currentDate = Date()
        label.text = formatter.string(from: currentDate)

    }
    
    func drawBase() {
    
        let radius: CGFloat = frame.width / 2
        let startAngle: CGFloat = CGFloat(π * 3 / 2)
        let endAngle: CGFloat = CGFloat(startAngle + CGFloat(4.0 * π / 2.0))
        
        let clockPath = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
        clockLayer = CAShapeLayer()
        clockLayer.path = clockPath.cgPath
        clockLayer.fillColor = clockFillColor
        clockLayer.strokeColor = clockStrokeColor
        clockLayer.lineWidth = 6.0
        
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
    
        
        
    }
    
    func drawMinute() {
    
        
        
    }
    
    func drawsSecond() {
    
    
    }
}
