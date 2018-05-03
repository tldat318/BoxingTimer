//
//  ViewController.swift
//  BoxingTimer
//
//  Created by User on 4/13/18.
//  Copyright © 2018 Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

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

    }
    @IBAction func abtn_pause(_ sender: Any) {
        btn_resume.isHidden = false
        btn_pause.isHidden = true
    }
    @IBAction func abtn_stop(_ sender: Any) {
    }
    @IBAction func abtn_resume(_ sender: Any) {
        btn_pause.isHidden = false
        btn_resume.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
