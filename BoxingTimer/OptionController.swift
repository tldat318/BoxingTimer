//
//  OptionController.swift
//  BoxingTimer
//
//  Created by User on 4/24/18.
//  Copyright © 2018 Dat. All rights reserved.
//

import UIKit
let numberofround = ["1","2","3","4","5","6","7","8","9","10"]
let roundlenght = ["30","60","120","150","180","210","240","270","300","330","360"]
let breaklenght = ["15","30","45","60","75","90","105","120"]
let roundendnotice = ["10","15"]
let breakendnotice = ["10","15"]
var totaltime = ""
var breaktime = ""
var NoticeRoundEnd = ""
var NoticeBreakEnd = ""
var Number = ""


class OptionController: UIViewController,AKPickerViewDelegate,AKPickerViewDataSource {
    
    @IBAction func abtn_back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var NumberRound: AKPickerView!
    @IBOutlet weak var RoundLenght: AKPickerView!
    @IBOutlet weak var BreakLenght: AKPickerView!
    @IBOutlet weak var RoundEndNotice: AKPickerView!
    @IBOutlet weak var BreakEndNotice: AKPickerView!
    @IBOutlet weak var btn_Stick: UIButton!
    @IBOutlet weak var btn_Bell: UIButton!
    
    @IBAction func abtn_Bell(_ sender: UIButton) {
        UserDefaults.standard.set(2, forKey: "StickBell")
        
        btn_Stick.backgroundColor = UIColor(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 0.8)
        btn_Stick.layer.shadowOpacity = 0.8
        btn_Bell.backgroundColor = UIColor(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 0.8)
        btn_Bell.layer.shadowOpacity = 0.8
        soundName = "Bell"
        if let soundName = soundName{
            EndNotice(soundName)
            
        }
    }


    
    @IBAction func abtn_Stick(_ sender: UIButton ) {
        sender.isSelected = !sender.isSelected
       
        UserDefaults.standard.set(1, forKey: "StickBell")
        
        btn_Bell.backgroundColor = UIColor(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 0.8)
        btn_Bell.layer.shadowOpacity = 0.8
        btn_Stick.backgroundColor = UIColor(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 0.8)
        btn_Stick.layer.shadowOpacity = 0.8
        soundName = "Stick"
        if let soundName = soundName{
            EndNotice(soundName)
        }
        
}
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "StickBell") != nil
        {
            if UserDefaults.standard.integer(forKey: "StickBell") == 1
            {
                UserDefaults.standard.set("Stick", forKey: "StickBell")
                btn_Bell.backgroundColor = UIColor(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 0.8)
                btn_Bell.layer.shadowOpacity = 0.8
                btn_Stick.backgroundColor = UIColor(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 0.8)
                btn_Stick.layer.shadowOpacity = 0.8
            }else
            {
                UserDefaults.standard.set("Bell", forKey: "StickBell")
                btn_Stick.backgroundColor = UIColor(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 0.8)
                btn_Stick.layer.shadowOpacity = 0.8
                btn_Bell.backgroundColor = UIColor(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 0.8)
                btn_Bell.layer.shadowOpacity = 0.8
            }
        }else
        {
            UserDefaults.standard.set(1, forKey: "StickBell")
            UserDefaults.standard.set("Stick", forKey: "StickBell")
            btn_Bell.backgroundColor = UIColor(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 0.8)
            btn_Bell.layer.shadowOpacity = 0.8
            btn_Stick.backgroundColor = UIColor(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 0.8)
            btn_Stick.layer.shadowOpacity = 0.8
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        btn_Bell.backgroundColor = UIColor(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 0.8)
        btn_Stick.backgroundColor = UIColor(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 0.8)
//        btn_Stick.layer.shadowOpacity = 0.8
//        btn_Bell.layer.shadowOpacity = 0.8
        
        self.NumberRound.delegate = self
        self.NumberRound.dataSource = self
        self.NumberRound.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.NumberRound.highlightedFont = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.NumberRound.pickerViewStyle = .wheel
        self.NumberRound.maskDisabled = false
        self.NumberRound.reloadData()
        NumberRound.interitemSpacing = 115
        NumberRound.textColor = UIColor.gray
        NumberRound.highlightedTextColor = UIColor.white
        
        self.RoundLenght.delegate = self
        self.RoundLenght.dataSource = self
        self.RoundLenght.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.RoundLenght.highlightedFont = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.RoundLenght.pickerViewStyle = .wheel
        self.RoundLenght.maskDisabled = false
        self.RoundLenght.reloadData()
        RoundLenght.interitemSpacing = 115
        RoundLenght.textColor = UIColor.gray
        RoundLenght.highlightedTextColor = UIColor.white
        
        self.BreakLenght.delegate = self
        self.BreakLenght.dataSource = self
        self.BreakLenght.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.BreakLenght.highlightedFont = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.BreakLenght.pickerViewStyle = .wheel
        self.BreakLenght.maskDisabled = false
        self.BreakLenght.reloadData()
        BreakLenght.interitemSpacing = 115
        BreakLenght.textColor = UIColor.gray
        BreakLenght.highlightedTextColor = UIColor.white
        
        self.RoundEndNotice.delegate = self
        self.RoundEndNotice.dataSource = self
        self.RoundEndNotice.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.RoundEndNotice.highlightedFont = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.RoundEndNotice.pickerViewStyle = .wheel
        self.RoundEndNotice.maskDisabled = false
        self.RoundEndNotice.reloadData()
        RoundEndNotice.interitemSpacing = 115
        RoundEndNotice.textColor = UIColor.gray
        RoundEndNotice.highlightedTextColor = UIColor.white
        
        self.BreakEndNotice.delegate = self
        self.BreakEndNotice.dataSource = self
        self.BreakEndNotice.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.BreakEndNotice.highlightedFont = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.BreakEndNotice.pickerViewStyle = .wheel
        self.BreakEndNotice.maskDisabled = false
        self.BreakEndNotice.reloadData()
        BreakEndNotice.interitemSpacing = 115
        BreakEndNotice.textColor = UIColor.gray
        BreakEndNotice.highlightedTextColor = UIColor.white
        
       btn_Stick.layer.cornerRadius = 6
        btn_Bell.layer.cornerRadius = 6
    }
    //Datasource
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        if pickerView.tag == 0
        {
            return numberofround.count
        }else
        if pickerView.tag == 1 {
            return roundlenght.count
        }else
        if pickerView.tag == 2
        {
            return breaklenght.count
        }else
        if pickerView.tag == 3 {
            return roundendnotice.count
        }else
        {
            return breakendnotice.count
        }
    }
    //
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        if pickerView.tag == 0
        {
            return numberofround[item]
        }else
            if pickerView.tag == 1 {
                let a = getCalculatedIntegerFrom(strings: [roundlenght[item]])
                let fm_number = timeFormatted(a)
                
                return fm_number
            }else
                if pickerView.tag == 2
                {
                    let a = getCalculatedIntegerFrom(strings: [breaklenght[item]])
                    let fm_number = timeFormatted(a)
                    return fm_number
                }else
                    if pickerView.tag == 3 {
                        let a = getCalculatedIntegerFrom(strings: [roundendnotice[item]])
                        let fm_number = timeFormatted(a)
                        return fm_number
                }else
                    {
        let a = getCalculatedIntegerFrom(strings: [breakendnotice[item]])
        let fm_number = timeFormatted(a)
        return fm_number
                        }
    }
    
    //delegate

    
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int){
        
        if pickerView.tag == 0
        {
            Number = numberofround[item]
            
        
        }else
        if pickerView.tag == 1
        {
           totaltime = roundlenght[item]
   
            
         
        }else
            if pickerView.tag == 2
            {
                breaktime = breaklenght[item]
          
              
        }else
                if pickerView.tag == 3
                {
                    NoticeRoundEnd = roundendnotice[item]
             
                    
        }else
                {
                   NoticeBreakEnd = breakendnotice[item]
                    
                    }
    }
    
    
   


}
