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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setdedault()
        
        if let number = UserDefaults.standard.value(forKey: "number") as? String{
          numbertoInt = getCalculatedIntegerFrom(strings: [number])
        }
        if let round = UserDefaults.standard.value(forKey: "round") as? String{
            time = getCalculatedIntegerFrom(strings: [round])
        }
        if let timebreak = UserDefaults.standard.value(forKey: "timebreak") as? String{
            breaktimeToInt = getCalculatedIntegerFrom(strings: [timebreak])
        }

        if let noticeround = UserDefaults.standard.value(forKey: "noticeround") as? String{
            NoticeRoundtoInt = getCalculatedIntegerFrom(strings: [noticeround])
        }
        if let noticebreak = UserDefaults.standard.value(forKey: "noticebreak") as? String{
            NoticeBreakToInt = getCalculatedIntegerFrom(strings: [noticebreak])
        }
        btn_resume.layer.cornerRadius = 12
        btn_pause.layer.cornerRadius = 12
        btn_stop.layer.cornerRadius = 12
        txt_timer.text = "\(numberofround[0]) Round"
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
    //method
    func StartTime()
    {
        
       Countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
       
    }

    @objc func UpdateTime()
    {
        CountdownTime.text = "\(timeFormatted(time))"
        if countdownready != 0
        {
            countdownready -= 1
            ready()
            CountdownTime.text = "\(countdownready)"
            if countdownready == 0
            {
                beginfight()
            }
        }
        if countdownready == 0
        {
            if time != 0
            {
                time -= 1
                Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 80/255, green: 184/255, blue: 34/255, alpha: 1)
                txt_timer.text = "Round \(numbertoInt)"
                if time <= NoticeRoundtoInt
                {
                    
                    Backgrondlbl.backgroundColor = UIColor.init(displayP3Red:  209/255, green: 116/255, blue: 25/255, alpha: 1)
                    txt_timer.text = "Round \(numbertoInt)"
                }
                
            }
            else if time == 0
            {
                CountdownTime.text = "\(timeFormatted(breaktimeToInt))"
                if breaktimeToInt != 0
                {
                    breaktimeToInt -= 1
                    Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 209/255, green: 25/255, blue: 56/255, alpha: 1)
                    txt_timer.text = "Break"
                    if breaktimeToInt <= NoticeBreakToInt
                    {
                        Backgrondlbl.backgroundColor = UIColor.init(displayP3Red:  209/255, green: 116/255, blue: 25/255, alpha: 1)
                        txt_timer.text = "Break"
                    }
                }
                    
                else if breaktimeToInt == 0
                {
                    if numbertoInt != 0
                    {
                        numbertoInt -= 1
                        print(numbertoInt)
                        time = getCalculatedIntegerFrom(strings: [totaltime])
                        breaktimeToInt = getCalculatedIntegerFrom(strings: [breaktime])
                        self.restart()
                         StartTime()
                        if numbertoInt == 1
                        {
                            breaktimeToInt = 0
                           
                        }else if numbertoInt == 0
                        {
                            StopTime()
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
        time = 0
        Backgrondlbl.backgroundColor = UIColor.init(displayP3Red: 80/255, green: 184/255, blue: 34/255, alpha: 1)
        txt_timer.text = "Finish"
    }
    func setdedault()
    {
        if Number.isEmpty == true
        {
            numbertoInt = 1
        }
        if totaltime.isEmpty == true
        {
            time = 30
        }
        if breaktime.isEmpty == true
        {
            breaktimeToInt = 15
        }
        if NoticeRoundEnd.isEmpty == true
        {
            NoticeRoundtoInt = 5
        }
        if NoticeBreakEnd.isEmpty == true
        {
            NoticeBreakToInt = 5
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
    //music
    func beginfight() {
        do{
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "BeginFight", ofType: "wav")!))
            player.prepareToPlay()
            player.play()
        }
        catch let error {
            print(error)
        }
    }
    
    func ready() {
        do{
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ready", ofType: "wav")!))
            player.prepareToPlay()
            player.play()
        }
        catch let error {
            print(error)
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

