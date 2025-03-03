//
//  ViewController.swift
//  WorldTrotter-Atheer Abdullah-iter2
//
//  Created by Atheer abdullah on 20/03/1443 AH.
//


import UIKit

class ViewwController:
  UIViewController {
  var textBackup = String()
  
  
  let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 0
    nf.maximumFractionDigits = 1
    return nf }()
  
  
  @IBOutlet weak var celsrusLabel: UILabel!
  
  @IBOutlet weak var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
      
      didSet {
        updateCelsiusLabel()
      }
    }
    
    
    var celsiusValue: Measurement<UnitTemperature>? {
      if let fahrenheitValue = fahrenheitValue {
        return fahrenheitValue.converted(to: .celsius)
      } else {
        return nil }
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      print("ConversionViewController loaded its view.")
      
      updateCelsiusLabel()
      
    }
    

  @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
    
    if var text = sender.text {
      text = text.trimmingCharacters(in: .whitespaces)
      if let number = numberFormatter.number(from: text) {
   fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
      } else {
        // Cannot convert text to valid number format
        if text.isEmpty || text == "." || text == "-" || text == "-." {
          // Accept text. Adding further input may make it a valid number
  fahrenheitValue = nil
        } else {
          // Reject text. Restore backup
          text = textBackup
        }
      }
      
      textField.text = text
      textBackup = text
    } else {
      // textField.text == nil
      fahrenheitValue = nil
    }
  }
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    textField.resignFirstResponder()
  }


func updateCelsiusLabel() {
  
  if let celsiusValue = celsiusValue {
    celsrusLabel.text =
      numberFormatter.string(from: NSNumber(value: celsiusValue.value))
  } else {
    celsrusLabel.text = "???"
  }



func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  
  let newText: String
  if let oldText = textField.text {
    let startIndex = oldText.index(oldText.startIndex, offsetBy: range.location)
    let endIndex = oldText.index(startIndex, offsetBy: range.length)
    let replacementRange = startIndex..<endIndex
    newText = oldText.replacingCharacters(in: replacementRange, with: string)
  } else {
    newText = string
  }
  
  print("New text: \(newText) ", terminator: "")
  if Double(newText) != nil || newText.isEmpty || newText == "-" || newText == "." {
    print("Accepted")
    return true
  } else {
    print("Rejected")
    return false
  }
}
}
}
