//
//  HomeViewController.swift
//  vehicleEval
//
//  Created by LouieDavis on 7/20/17.
//  Copyright © 2017 jpsautner. All rights reserved.
//

import UIKit
import WCLShineButton

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        var param1 = WCLShineParams()
//        param1.bigShineColor = UIColor(rgb: (153,152,38))
//        param1.smallShineColor = UIColor(rgb: (102,102,102))
//        let bt1 = WCLShineButton(frame: .init(x: view.frame.width/2, y: 150, width: 60, height: 60), params: param1)
//        bt1.fillColor = UIColor(rgb: (15,252,138))
//        bt1.color = UIColor(rgb: (170,170,170))
//        bt1.addTarget(self, action: #selector(printSome), for: .touchUpInside)
//        view.addSubview(bt1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printSome() {
        print("Hello")
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    
}
