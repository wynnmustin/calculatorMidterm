//
//  ViewController.swift
//  Calculator_Homework_10_21_15
//
//  Created by Wynn Mustin on 10/21/15.
//  Copyright (c) 2015 Wynn Mustin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    // Speach Related
    let mySpeechSynth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "Hi View Did Load")
    
    var myRate: Float = 0.50
    var myPitch: Float = 1.15
    var myVolume: Float = 0.92
    
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    
//    var currentColor =
    
    // calc related
    var currentString = ""
    // var currentNumber: Int = 100
    var firstNumber = 0
    var secondNumber = 0
    
    let numberButtons = UIButton()
    
    var total = 0
    var mode = 0
    var valueString:String! = ""
    var totalEquals:Bool = false
    var lastButtonWasMode:Bool = false
    
    
    
    @IBOutlet weak var label: UILabel!

    @IBAction func colorSwitch(sender: UISwitch) {
        
        if(sender.on) {
            self.numberButtons.backgroundColor = UIColor.greenColor()
            
            self.view.backgroundColor = UIColor.darkGrayColor()
//            label.backgroundColor = UIColor.yellowColor()
            
            
            
            
            
        } else {
            self.view.backgroundColor = UIColor.whiteColor()
            self.numberButtons.backgroundColor=UIColor.purpleColor()
//            
//            label.backgroundColor = UIColor.blueColor()
        }
        
  
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mySpeechSynth.speakUtterance(myUtterance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
 
    

    
    
    //MARK - UIPickerView Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCodeAll38.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let myString = "\(langCodeAll38[row].4) \(langCodeAll38[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLang = langCodeAll38[row]
        speakThisString(currentLang.3)
        
        
        
        
    }
  
    
    
    @IBAction func tappedNumber(sender: UIButton) {
        
    
        
        
        if (totalEquals){
            valueString = ""
            totalEquals = false
        }
        
        var str:String! = sender.titleLabel!.text
        var num:Int! = str.toInt()
        if (num == 0 && total == 0) {
            return
            //this means don't run anymore code before that line
        }
        if (lastButtonWasMode)
        {
            lastButtonWasMode = false
            valueString = ""
        }
        valueString = valueString.stringByAppendingString(str)
        
        var formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        var n:NSNumber = formatter.numberFromString(valueString)!
        
        
        label.text = formatter.stringFromNumber(n)
        
        
        if (total == 0){
            total = valueString.toInt()!
            
        }
        
        
        
        speakThisString(valueString)
    }
    
    
    @IBAction func tappedPlus(sender: AnyObject) {
        self.setMode1(1)

    }
    
    
    @IBAction func tappedMinus(sender: AnyObject) {
        self.setMode1(-1)

        
    }
    
    
    @IBAction func tappedX(sender: AnyObject) {
        self.setMode1(2)

    }
    
    
   
    @IBAction func tappedEquals(sender: AnyObject) {
        if (mode == 0)
        {
            return
        }
        var iNum: Int = valueString.toInt()!
        if (mode == 1)
        {
            total += iNum
        }
        if (mode == -1)
        {
            total -= iNum
        }
        if (mode == 2)
        {
            total *= iNum
        }
        
        
        
        valueString = "\(total)"
        label.text = valueString
        mode = 0
        
        
        speakThisString(valueString)
        totalEquals = true
    }
    
    
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
    }
    
    func setMode1(m:Int){
        
        if (total == 0)
        {
            return
        }
        mode = m
        lastButtonWasMode = true
        total = valueString.toInt()!
    }

    func speakThisString(passedString: String){
        
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        mySpeechSynth.speakUtterance(myUtterance)
        
        
        
    }
    
    //MARK - Data Model
    
    // current lang array has known typos, to fix in future.
    var langCodeAll38 = [
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),
        ("id-ID",       "Indonesian",    "Indonesia","Bahasa Indonesia","🇮🇩"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]
    
}





