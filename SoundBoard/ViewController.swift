//
//  ViewController.swift
//  SoundBoard
//
//  Created by KR DEVARAJAN NAIR on 2017/02/27.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var records:[Record]=[]
    var audioPlayer=AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblView.dataSource=self
        tblView.delegate=self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tblView.reloadData()
    }
    
    func fetchData(){
        let context=UIApplication.shared.delegate as! AppDelegate
        do{
            records=try context.persistentContainer.viewContext.fetch(Record.fetchRequest())
        }
        catch {
            print("error occured")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let selRec=records[indexPath.row]
        cell.textLabel?.text=selRec.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selRow=records[indexPath.row]
        do{
            try audioPlayer = AVAudioPlayer(data: selRow.sound as! Data)
            audioPlayer.play()
        }
        catch {
            print(error)
        }
        tblView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let context = UIApplication.shared.delegate as! AppDelegate
            let selRow=records[indexPath.row]
            context.persistentContainer.viewContext.delete(selRow)
            context.saveContext()
            fetchData()
            tblView.reloadData()
        }
    }
}

