//
//  ViewController.swift
//  Calculator
//
//  Created by Safa Falaqi on 05/12/2021.
//

import UIKit

class ViewController: UIViewController {

    var expression = ""
    var isCalculated = false
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //when button clicked it will check the tag to decide the action
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.tag{
        case 0:  numberEntered("0")//0
        case 1:  numberEntered("1")//1
        case 2:  numberEntered("2")//2
        case 3:  numberEntered("3")//3
        case 4:  numberEntered("4")//4
        case 5:  numberEntered("5")//5
        case 6:  numberEntered("6")//6
        case 7:  numberEntered("7")//7
        case 8:  numberEntered("8")//8
        case 9:  numberEntered("9")//9
        case 10:  operatorPressed("+")
        case 11:  operatorPressed("-")
        case 12:  operatorPressed("*")
        case 13:  operatorPressed("/")
        case 14: numberEntered(".")//.
        case 15:  calculate()
        case 16:  numberEntered("%")
        case 17:  numberEntered("negative")
        default: clearNumber() //clear
        }
    }
    
    func calculate(){
        if let text = result.text{
        expression = expression  + text
            
        let exp: NSExpression = NSExpression(format: expression)
        let r: Double = exp.expressionValue(with:nil, context: nil) as! Double
            
            result.text = String(r)
            expression = ""
          //  isCalculated = true
        }
        
    }
    
    func operatorPressed(_ op:String){
        if let text = result.text{
            expression = expression  + text + op
            result.text  = ""
        }
    }
    
    func numberEntered(_ number:String){
        
        //if the initial value is zero clear it to be replaced by a the new number
        if result.text == "0" {
            result.text = ""
        }
 
        switch number{
        case "0","1","2","3","4","5","6","7","8","9" :  if let text = result.text {
            result.text = text + "\(number)"
        }
        case "negative":
            if let text = result.text{
                
                if  !text.contains("-") && text != "0"{
                result.text = "-" + text
                }else if text.contains("-"){
                    result.text = text.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                     }
        }
        case "%":
            if let text = result.text{
                
                if  !text.isEmpty{
                    
                    let rs = text + "/100"
                        
                    let exp: NSExpression = NSExpression(format: rs)
                    let r: Double = exp.expressionValue(with:nil, context: nil) as! Double
                    
                    result.text = String(r)
                }
            }
        
        default:
            //here we will check for "." to be entered only one time and if entered first concatenate it with 0
            if let text = result.text{
                //if the label is empty
                if text.isEmpty
                {
                    result.text = "0" + "."
                    //if not empty and doesnt contain "."
                } else if !text.contains(".") && !text.isEmpty{
                    result.text = text + "."
                }
            }
        }
    }

    
    func clearNumber()
    {
        result.text = ""
        expression = ""
    }
    
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
