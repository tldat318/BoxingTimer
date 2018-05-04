//
//  ViewController.swift
//  BoxingTimer
//
//  Created by User on 4/13/18.
//  Copyright © 2018 Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var Countdown:Timer!
    var time = getCalculatedIntegerFrom(strings: [totaltime])
    var a = getCalculatedIntegerFrom(strings: [breaktime])
    var b = getCalculatedIntegerFrom(strings: [NoticeRoundEnd])
    var c = getCalculatedIntegerFrom(strings: [NoticeBreakEnd])
    var countdownready = 4
    var breaktimeToInt = getCalculatedIntegerFrom(strings: [breaktime])
    var NoticeBreakToInt = getCalculatedIntegerFrom(strings: [NoticeBreakEnd])
    var numbertoInt = getCalculatedIntegerFrom(strings: [Number])
    
    @IBOutlet weak var lbl_detail2: UILabel!
    @IBOutlet weak var lbl_detail1: UILabel!
    @IBOutlet weak var btn_resume: UIButton!
    @IBOutlet weak var btn_stop: UIButton!
    @IBOutlet weak var btn_pause: UIButton!
    @IBOutlet weak var Backgrondlbl: UIView!
    @IBOutlet weak var CountdownTime: UILabel!
    @IBOutlet weak var txt_timer: UILabel!
    @IBOutlet weak var btn_StarFight: UIButton!
    @IBAction func abtn_StartFight(_ sender: Any) {
        Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 1)
        txt_timer.text = "Get Ready"
        txt_timer.isHidden = false
        btn_StarFight.isHidden = true
        CountdownTime.isHidden = false
        btn_stop.isHidden = false
        btn_pause.isHidden = false
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_resume.layer.cornerRadius = 6
        btn_pause.layer.cornerRadius = 6
        btn_stop.layer.cornerRadius = 6
        txt_timer.text = "\(numberofround[0]) Round"
        lbl_detail1.text = "Rounds: \(timeFormatted(time))/ notice: \(timeFormatted(b))"
        lbl_detail2.text = "Rounds: \(timeFormatted(a))/ notice: \(timeFormatted(c))"
        if Number == "1"
        {
        txt_timer.text = "\(Number) Round"
        }
        else
        {
            txt_timer.text = "\(Number) Rounds"
        }
     
    }
    func StartTime()
    {
        timer 2:30
        round =- 1
        Countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
        
    }
    start(){
        Countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateTime()
    {
        
        if timer == 0{
            if round != 0{
                round =- 1
                start()
                
            }else{
                stop()
            }
            
            
        }else{
            timer =- 1
        }
        
        for i in 1...numbertoInt
        {
            CountdownTime.text = "\(timeFormatted(time))"
            if i < numbertoInt
            {
                    if countdownready != 0
                {
                    countdownready -= 1
                    print(countdownready)
                    CountdownTime.text = "\(countdownready)"
                }
                    else
                {
                    
                    if time != 0
                    {
                        time -= 1
                        Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 80/255, green: 184/255, blue: 34/255, alpha: 1)
                        txt_timer.text = "Round \(i)"
                        if time <= breaktimeToInt
                        {
                            
                            Backgrondlbl.backgroundColor = UIColor.init(displayP3Red:  209/255, green: 116/255, blue: 25/255, alpha: 1)
                            txt_timer.text = "Round \(i)"
                        }
                        
                    }
                    else
                    {
                        CountdownTime.text = "\(timeFormatted(a))"
                        if a != 0
                        {
                            a -= 1
                            Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 1)
                            txt_timer.text = "Break"
                            if a <= NoticeBreakToInt
                            {
                                Backgrondlbl.backgroundColor = UIColor.init(displayP3Red:  209/255, green: 116/255, blue: 25/255, alpha: 1)
                                txt_timer.text = "Break"
                            }
                        }
                            
                        else
                        {
                            StopTime()
                        }
                    }
                    
                }
                
            }
            print(i)
        }
      
    }
    
    
    func StopTime()
    {
        if Countdown != nil
        {
            Countdown.invalidate()
            Countdown = nil
           
        }
    }
    
    @IBAction func abtn_pause(_ sender: Any) {
        btn_resume.isHidden = false
        btn_pause.isHidden = true
        StopTime()
    }
    @IBAction func abtn_stop(_ sender: Any) {
        StopTime()
        CountdownTime.text = "00:00"
        totaltime = ""
    }
    @IBAction func abtn_resume(_ sender: Any) {
        btn_pause.isHidden = false
        btn_resume.isHidden = true
        StartTime()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
