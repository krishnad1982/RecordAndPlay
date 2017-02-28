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
    var audioPlayer=AVAudioPlayer()
    var audioUrl:URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpRecorder()
    lblPlay.isEnabled=false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpRecorder(){
        do{
            // Activate AudioSession
            let session=AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //Create audio URL
            let basePath:String=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents=[basePath,"audio1.m4a"]
            audioUrl=NSURL.fileURL(withPathComponents: pathComponents)
            txtTitle.text=String(describing: audioUrl)
            //Add settings to dictionary
            var settings:[String:Any]=[:]
            settings[AVFormatIDKey]=Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey]=44100.0
            settings[AVNumberOfChannelsKey]=2
            
            audioRecorder=try AVAudioRecorder(url: audioUrl!, settings: settings)
            audioRecorder!.prepareToRecord()
        }
            
        catch let error as NSError{
            print(error)
        }
        
        
    }
    
    @IBAction func btnRecord(_ sender: AnyObject) {
        if audioRecorder!.isRecording{
            audioRecorder?.stop()
            lblRecord.setTitle("Record", for: .normal)
            lblPlay.isEnabled=true
        }
        else{
            audioRecorder?.record()
            lblRecord.setTitle("Stop", for: .normal)
        }
    }
    
    
    @IBAction func btnPlay(_ sender: AnyObject) {
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: audioUrl!)
            audioPlayer.play()
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func btnAdd(_ sender: AnyObject) {
        
    }
}
