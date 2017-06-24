//
//  FirstPageViewController.swift
//  NotesApp
//
//  Created by Jenhao on 2016-12-09.
//  Copyright © 2016 Jenhao.ca. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {


    @IBOutlet weak var LabelDate: UILabel!

    @IBOutlet weak var LabelTime: UILabel!

    @IBOutlet weak var LabeSayHi: UILabel!

    @IBOutlet weak var ImageBackGround: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update every second
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(FirstPageViewController.updateTime), userInfo: nil, repeats: true)
        

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(FirstPageViewController.updateTime), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "AddNew" {

            let detail = segue.destination as! EditNoteViewController
            detail.viewType = enumViewType.ADD

            }

     
    }

    
    
    func updateTime(){
        
        // Do any additional setup after loading the view.
        
        let currentDate = NSDate()
        let date = NSDate()
        let calendar = NSCalendar.current
        let hour = String(calendar.component(.hour, from: date as Date))
        let minutes = String(calendar.component(.minute, from: date as Date))
        let sceond = String(calendar.component(.second, from: date as Date))
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd,YYYY"
        
        let Today = String(formatter.string(from: currentDate as Date))
        
        
        LabelDate.text = Today
        LabelTime.text = "\(hour):\(minutes):\(sceond)"
        
        let hourIf = Int(hour)!
        
        if  hourIf >= 5 && hourIf < 12  {
            LabeSayHi.text = "Good morning"
        }else  {
            LabeSayHi.text = "Good evening"
        }
        

        if hourIf >= 9 && hourIf < 10 {
            ImageBackGround.image = UIImage(named: "landscape01")
        }else if hourIf >= 10 && hourIf < 11 {
            ImageBackGround.image = UIImage(named: "landscape08")
        }else if hourIf >= 11 && hourIf < 13 {
            ImageBackGround.image = UIImage(named: "landscape06")
        }else if hourIf >= 13 && hourIf < 14 {
            ImageBackGround.image = UIImage(named: "landscape07")
        }else if hourIf >= 14 && hourIf < 15 {
            ImageBackGround.image = UIImage(named: "landscape08")
        }else if hourIf >= 15 && hourIf < 17 {
            ImageBackGround.image = UIImage(named: "landscape09")
        }else if hourIf >= 17 && hourIf < 20 {
            ImageBackGround.image = UIImage(named: "landscape10")
        }else if hourIf >= 20 && hourIf < 23 {
            ImageBackGround.image = UIImage(named: "landscape04")
        }else if hourIf >= 23 && hourIf <= 24 {
            ImageBackGround.image = UIImage(named: "landscape05")
        }else if hourIf >= 0 && hourIf < 5 {
            ImageBackGround.image = UIImage(named: "landscape05")
        }else if hourIf >= 5 && hourIf < 9 {
            ImageBackGround.image = UIImage(named: "landscape02")
        }

    }




    


}
