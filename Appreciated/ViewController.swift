//
//  ViewController.swift
//  Appreciated
//
//  Created by nguyen thy on 12/23/19.
//  Copyright © 2019 Han Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var calculateView: UIView!
    @IBOutlet weak var billFieldToTopSafeArea: NSLayoutConstraint!
    @IBOutlet weak var billFieldToCenter: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        // Get the default selected segment of tipControl
        let defaults = UserDefaults.standard
        let defaultSelectedSegment = defaults.integer(forKey: "selectedSegmentIndex")
        tipControl.selectedSegmentIndex = defaultSelectedSegment
        
        // Hide tipControl and calculateView
        tipControl.alpha = 0
        calculateView.isHidden = true
        
        // Make billField the center of Safe Area
        billFieldToTopSafeArea.priority = UILayoutPriority.defaultLow
        billFieldToCenter.priority = UILayoutPriority.defaultHigh
        self.view.layoutIfNeeded()
        billField.text = "$"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    override func viewDidLoad() {
        billField.becomeFirstResponder()
        super.viewDidLoad()
    }

    
    func springView(view: UIView) {
        // Move billField to the top of Safe Area
        billFieldToCenter.priority = UILayoutPriority.defaultLow
        billFieldToTopSafeArea.priority = UILayoutPriority.defaultHigh
        self.view.layoutIfNeeded()
        
        // Let tipControl appear
        tipControl.alpha = 1
        
        // Animate calculateView
        let xPosition = view.frame.minX
        let yPosition = view.frame.minY - 10
        let width = view.frame.width
        let height = view.frame.height + 10
        UIView.animate(withDuration:0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:[] ,
        animations: { () -> Void in
            view.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        }, completion: nil)
        calculateView.isHidden = false
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        print("Tap succeeded")
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        springView(view: calculateView)
        print("I'm calculating")
        // Get the bill amount
        let billAsString = billField.text!.replacingOccurrences(of: "$", with: "")
        let bill = Double(billAsString) ?? 0
        
        // Calculate the tip and total
        let tipPercentages = [0.1, 0.18, 0.2]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
         
        // Update the tip and total label
        tipLabel.text = String(format: "$%.2f", tip)
        tipLabel.sizeToFit()
        totalLabel.text = String(format: "$%.2f", total)
        totalLabel.sizeToFit()
    }
}

