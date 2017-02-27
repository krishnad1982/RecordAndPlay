//
//  AddViewController.swift
//  SoundBoard
//
//  Created by KR DEVARAJAN NAIR on 2017/02/27.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import AVFoundation

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var lblRecord: UIButton!
    @IBOutlet weak var lblPlay: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var lblAdd: UIButton!
    
    var audioRecorder:AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    function setUpRecorder(){
    
    
    }
    
    @IBAction func btnRecord(_ sender: AnyObject) {
        
    }
    
    
    @IBAction func btnPlay(_ sender: AnyObject) {
        
    }
    
    @IBAction func btnAdd(_ sender: AnyObject) {
        
    }
}
