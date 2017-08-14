//
//  ViewController.swift
//  CGClock
//
//  Created by Daniel Hjärtström on 2017-08-14.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let clock = Clock(rect: CGRect(x: 0, y: 0, width: 300, height: 300))
        clock.center = self.view.center
        
        self.view.addSubview(clock)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

