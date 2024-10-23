//
//  ViewController.swift
//  ExampleiOS
//
//  Created by Nafiz on 10/23/24.
//

import UIKit
import EssenFramework

class ViewController: UIViewController {
    @IBAction func openCalendarAction() {
        self.showCalendar()
    }
    
    @IBAction func openGoogle() {
        self.open(url: "https://google.com")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

