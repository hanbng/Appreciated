//
//  SettingsViewController.swift
//  Appreciated
//
//  Created by nguyen thy on 12/29/19.
//  Copyright © 2019 Han Nguyen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        let defaultSegmentIndex = defaults.integer(forKey: "selectedSegmentIndex")
        defaultTipControl.selectedSegmentIndex = defaultSegmentIndex
        super.viewDidLoad()
    }
    
    /*q
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func getDefaultTip(_ sender: Any) {
        let tipPercentages = [0.1, 0.18, 0.2]
        let selectedSegmentIndex = defaultTipControl.selectedSegmentIndex
        let defaultTipPercentage = tipPercentages[selectedSegmentIndex]
        let defaults = UserDefaults.standard
        defaults.set(defaultTipPercentage, forKey: "defaultTipPercentage")
        defaults.set(selectedSegmentIndex, forKey: "selectedSegmentIndex")
        defaults.synchronize()
    }
}
