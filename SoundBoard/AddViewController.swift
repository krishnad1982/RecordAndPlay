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
        lblAdd.isEnabled=false
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
            let nsdt=NSDate()
            let filename="\(nsdt) - audio.m4a"
            let pathComponents=[basePath,filename]
            
            audioUrl=NSURL.fileURL(withPathComponents: pathComponents)
            
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
            lblAdd.isEnabled=true
            self.view.backgroundColor=#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            audioRecorder?.record()
            lblRecord.setTitle("Stop", for: .normal)
            self.view.backgroundColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
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
        let context=UIApplication.shared.delegate as! AppDelegate
        let record:Record=Record(context: context.persistentContainer.viewContext)

        record.title=txtTitle.text
        record.sound=NSData(contentsOf: audioUrl!)
        
        context.saveContext()
        navigationController!.popViewController(animated: true)
    }
}
