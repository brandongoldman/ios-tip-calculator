//
//  ViewController.swift
//  Tip Calculator
//
//  Created by admin on 2/24/20.
//  Copyright © 2020 Brandon Goldman Inc. All rights reserved.
//

import UIKit

// Tip Calculator
class TipCalc {
    var tipPercentage = 0.0
    
    init (tp: Double) {
        tipPercentage = tp
    }
    
    func calcTip (amount: Double, tipPercentage: Double) -> Double {
        return amount * tipPercentage
    }
}

class ViewController: UIViewController {
    // Static Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var desiredTipLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var costPerPersonLabel: UILabel!
    
    // User Input
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var desiredTip: UISegmentedControl!
    @IBOutlet weak var numberOfPeople: UIStepper!
    
    // Calculated Values
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var numberOfPeopleValue: UILabel!
    @IBOutlet weak var costPerPersonValue: UILabel!
    
    // Views
    @IBOutlet weak var backgroundView: UIView!
    
    var totalBillAmount : Double = 0.0
    
    // Functions
    func tipCalculatorLogic() {
        let billAmountValueStr = billAmount.text! 
        let billAmountValue = Double(billAmountValueStr) ?? 0.0
        
        let desiredTipAmountValue = desiredTip.titleForSegment(at: desiredTip.selectedSegmentIndex)
        var desiredTipNumber : Double = 0.00
        let segmentOptions : [String] = ["10%", "15%", "20%", "25%"]
        let possibleTipAmounts : [Double] = [0.10, 0.15, 0.20, 0.25]
        
        if (desiredTipAmountValue == segmentOptions[0]) {
            desiredTipNumber = possibleTipAmounts[0]
        }
        
        if (desiredTipAmountValue == segmentOptions[1]) {
            desiredTipNumber = possibleTipAmounts[1]
        }
        
        if (desiredTipAmountValue == segmentOptions[2]) {
            desiredTipNumber = possibleTipAmounts[2]
        }
        
        if (desiredTipAmountValue == segmentOptions[3]) {
            desiredTipNumber = possibleTipAmounts[3]
        }
        
        // call tip calculator functions
        let tc = TipCalc(tp: desiredTipNumber)
        let r = tc.calcTip(amount: billAmountValue, tipPercentage: desiredTipNumber)
        totalBillAmount = (r + billAmountValue)
        
        tipAmount.text = String(format: "$%.02f", r)
        totalAmount.text = String(format: "$%.02f", totalBillAmount)
        costPerPersonValue.text = totalAmount.text
    }
    
    // Actions
    @IBAction func billAmountChangedAction(_ sender: Any) {
        tipCalculatorLogic()
    }
    
    @IBAction func desiredTipChangedAction(_ sender: Any) {
        tipCalculatorLogic()
    }
    
    @IBAction func numberOfPeopleSelection(_ sender: Any) {
        let num : Int = Int(numberOfPeople.value)
        let billTotalBeforeSplit = Double(totalBillAmount)
        let cpp = billTotalBeforeSplit/Double(num)
        numberOfPeopleValue.text = String(num)
        costPerPersonValue.text = String(format: "$%.02f", cpp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmount.becomeFirstResponder()
        backgroundView.layer.cornerRadius = 20
        numberOfPeopleValue.text = "1"
        costPerPersonValue.text = totalAmount.text
        
        // populate labels
        titleLabel.text = "Tip Calculator"
        billLabel.text = "Bill:"
        desiredTipLabel.text = "Desired Tip:"
        splitLabel.text = "Split:"
        costPerPersonLabel.text = "Cost per Person:"
    }
}
