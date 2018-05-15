//
//  ViewController.swift
//  BoxingTimer
//
//  Created by User on 4/13/18.
//  Copyright © 2018 Dat. All rights reserved.
//

import UIKit
import AVFoundation

var player = AVAudioPlayer()
var soundName:String? = nil
class MainViewController: UIViewController {
    var Countdown:Timer!
    var countdownready = 10
    var numbertoInt = getCalculatedIntegerFrom(strings: [Number])
    var time = getCalculatedIntegerFrom(strings: [totaltime])
    var breaktimeToInt = getCalculatedIntegerFrom(strings: [breaktime])
    var NoticeBreakToInt = getCalculatedIntegerFrom(strings: [NoticeBreakEnd])
    var NoticeRoundtoInt = getCalculatedIntegerFrom(strings: [NoticeRoundEnd])
    
    
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
       StartTime()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let number = UserDefaults.standard.value(forKey: "number") as? String{
            numbertoInt = getCalculatedIntegerFrom(strings: [number])
        }
        if let round = UserDefaults.standard.value(forKey: "round") as? String{
            time = getCalculatedIntegerFrom(strings: [round])
            totaltime = round
            
        }
        if let timebreak = UserDefaults.standard.value(forKey: "timebreak") as? String{
            breaktimeToInt = getCalculatedIntegerFrom(strings: [timebreak])
            breaktime = timebreak
        }
        
        if let noticeround = UserDefaults.standard.value(forKey: "noticeround") as? String{
            NoticeRoundtoInt = getCalculatedIntegerFrom(strings: [noticeround])
        }
        if let noticebreak = UserDefaults.standard.value(forKey: "noticebreak") as? String{
            NoticeBreakToInt = getCalculatedIntegerFrom(strings: [noticebreak])
        }
        
        if let stick = UserDefaults.standard.value(forKey: "stick") as? String{
            soundName = stick
        }
        btn_resume.layer.cornerRadius = 12
        btn_pause.layer.cornerRadius = 12
        btn_stop.layer.cornerRadius = 12
        txt_timer.text = "\(numbertoInt) Round"
        lbl_detail1.text = "Rounds: \(timeFormatted(time))/ notice: \(timeFormatted(NoticeRoundtoInt))"
        lbl_detail2.text = "Breaks: \(timeFormatted(breaktimeToInt))/ notice: \(timeFormatted(NoticeBreakToInt))"
        if numbertoInt == 1
        {
            txt_timer.text = "\(numbertoInt) Round"
        }
        else
        {
            txt_timer.text = "\(numbertoInt) Rounds"
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setdefault()
     
    }
    //method
    func StartTime()
    {
        
        Countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func UpdateTime()
    {
        
        
        if countdownready != 0
        {
            countdownready -= 1
            if countdownready == 0
            {
                fight()
            }else
            {
                ready()
            }
            CountdownTime.text = "\(countdownready)"
        }
        if countdownready == 0
        {
            if time != 0
            {
                
                time -= 1
                Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 80/255, green: 184/255, blue: 34/255, alpha: 1)
                txt_timer.text = "Round \(numbertoInt)"
                CountdownTime.text = "\(timeFormatted(time))"
                if time <= NoticeRoundtoInt
                {
                    CountdownTime.text = "\(timeFormatted(time))"
                    print(time)
                    Backgrondlbl.backgroundColor = UIColor.init(displayP3Red:  209/255, green: 116/255, blue: 25/255, alpha: 1)
                    txt_timer.text = "Round \(numbertoInt)"
                }
                if time == NoticeRoundtoInt
                {
                    if UserDefaults.standard.object(forKey: "StickBell") != nil
                    {
                        if UserDefaults.standard.integer(forKey: "StickBell") == 1
                        {
                            soundName = "Stick"
                        }else
                        {
                            soundName = "Bell"
                        }
                    }else
                    {
                        soundName = "Stick"
                    }
                    EndNotice(soundName!)
                }else if time == 0 && numbertoInt  > 1{
                breaktimewarning()
                }
            }
            else if time == 0
            {
                if breaktimeToInt != 0
                {
                    CountdownTime.text = "\(timeFormatted(breaktimeToInt))"
                    breaktimeToInt -= 1
                    
                    Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 1)
                    txt_timer.text = "Break"
                    if breaktimeToInt <= NoticeBreakToInt
                    {
                        Backgrondlbl.backgroundColor = UIColor.init(displayP3Red:  209/255, green: 116/255, blue: 25/255, alpha: 1)
                        txt_timer.text = "Break"
                        if breaktimeToInt == 0
                        {
                            fight()
                        }
                    }
                    if breaktimeToInt == NoticeBreakToInt
                    {
                        if UserDefaults.standard.object(forKey: "StickBell") != nil
                    {
                        if UserDefaults.standard.integer(forKey: "StickBell") == 1
                        {
                            soundName = "Stick"
                        }else
                        {
                            soundName = "Bell"
                        }
                    }else
                    {
                        soundName = "Stick"
                        }
                        EndNotice(soundName!)
                        
                    }
                    CountdownTime.text = "\(timeFormatted(breaktimeToInt))"
                }
                else if breaktimeToInt == 0
                {
                    if numbertoInt != 0
                    {
                        numbertoInt -= 1
                        time = getCalculatedIntegerFrom(strings: [totaltime])
                        breaktimeToInt = getCalculatedIntegerFrom(strings: [breaktime])
                        self.restart()
                        StartTime()
                        if numbertoInt == 0
                        {
                            numbertoInt = getCalculatedIntegerFrom(strings: [Number])
                            endfight()
                            StopTime()
                      
                           
                        }
                        else
                        {
                            stopMusic()
                            breaktimeToInt = 0
                        }
                        }
                    }
                }
            }
    }

    
    func restart(){
        if Countdown != nil
        {
            Countdown.invalidate()
            Countdown = nil
        }
    }
    func pause()
    {
        if Countdown != nil
        {
            Countdown.invalidate()
            Countdown = nil
            
        }
    }
    func StopTime()
    {
        
        if Countdown != nil
        {
            Countdown.invalidate()
            Countdown = nil
        }
        Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 80/255, green: 184/255, blue: 34/255, alpha: 1)
        txt_timer.text = "Finish"
       
    }
    func setdefault()
    {
        if Number.isEmpty == true
        {
            numbertoInt = 1
        }
        if totaltime.isEmpty == true
        {
            time = 60
            totaltime = "60"
        }
        
        if breaktime.isEmpty == true
        {
            breaktimeToInt = 30
            breaktime = "30"
        }
        if NoticeRoundEnd.isEmpty == true
        {
            NoticeRoundtoInt = 10
        }
        if NoticeBreakEnd.isEmpty == true
        {
            NoticeBreakToInt = 10
        }
    }
    
    
    @IBAction func abtn_pause(_ sender: Any) {
        btn_resume.isHidden = false
        btn_pause.isHidden = true
        pause()
    }
    @IBAction func abtn_stop(_ sender: Any) {
        
        time = getCalculatedIntegerFrom(strings: [totaltime])
        btn_stop.isHidden = true
        btn_pause.isHidden = true
        btn_resume.isHidden = true
        btn_StarFight.isHidden = false
        Backgrondlbl.backgroundColor = UIColor.black
        if Number == "1"
        {
            txt_timer.text = "\(Number) Round"
        }
        else
        {
            txt_timer.text = "\(Number) Rounds"
        }
       CountdownTime.isHidden = true
        pause()
        CountdownTime.text = "00:00"
        countdownready = 10
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

