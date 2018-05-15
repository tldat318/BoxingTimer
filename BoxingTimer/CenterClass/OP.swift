//
//  OP.swift
//  BoxingTimer
//
//  Created by User on 4/27/18.
//  Copyright © 2018 Dat. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
extension NSObject {
    
    /// Convert String to Date
    func convertToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatType.date.rawValue // Your date format
        let serverDate: Date = dateFormatter.date(from: dateString)! // according to date format your date string
        return serverDate
    }
    
    /// Convert Date to String
    func convertToString(date: Date, dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue // Your New Date format as per requirement change it own
        
        let newDate: String = dateFormatter.string(from: date) // pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
    /// Diviation calculation
    func convertToSeconds(timeString: String, dateFormat type: DateFormatType) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        
        let date: Date = dateFormatter.date(from: timeString)!
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute, .second], from: date)
        let hour = comp.hour
        let minute = comp.minute
        let sec = comp.second
        
        let totalSeconds = ((hour! * 60) * 60) + (minute! * 60) + sec!
        
        return totalSeconds
    }
    
    
    /// To Show the Date in String format
    func convertToShowFormatDate(dateString: String) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd hh:mm a" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
}   

    //convert String -> Int
    func getCalculatedIntegerFrom(strings: [String]) -> Int {
        
        var result = Int()
        
        for element in strings {
            
            guard let int = Int(element) else {
                break // or return nil
                // break instead of return, returns Integer of all
                // the values it was able to turn into Integer
                // so even if there is a String f.e. "123S", it would
                // still return an Integer instead of nil
                // if you want to use return, you have to set "-> Int?" as optional
            }
            
            result = result + int
            
        }
        
        return result
        
}
    
    /// Date Format type
    enum DateFormatType: String {
        /// Time
        case time = "HH:mm:ss"
        
        /// Date with hours
        case dateWithTime = "yyyy-MM-dd HH:mm:ss"
        
        /// Date
        case date = "dd-MMM-yyyy"
    }

    //timeformat
    func timeFormatted(_ TotalSeconds: Int)-> String
    {
        let seconds:Int = TotalSeconds % 60
        let minutes:Int = (TotalSeconds / 60) % 60
        //let hours:Int = TotalSeconds / 3600
        return String(format: "%02d:%02d",minutes,seconds)
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

func endfight() {
    do{
        player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "EndFight", ofType: "wav")!))
        player.prepareToPlay()
        player.play()
    }
    catch let error {
        print(error)
    }
}
func fight() {
    do{
        player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Fight", ofType: "wav")!))
        //player.prepareToPlay()
        player.play()
    }
    catch let error {
        print(error)
    }
}
func EndNotice(_ Name:String) {
    do{
        if let soundName = soundName
        {
        player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "wav")!))
        }
        //player.prepareToPlay()
        player.play()
    }
    catch let error {
        print(error)
    }
}
    func breaktimewarning() {
        do{
                player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Breaktime", ofType: "mp3")!))
            
            //player.prepareToPlay()
            player.play()
        }
        catch let error {
            print(error)
            }
        }
func stopMusic()
{
    
    player.stop()
    
}







