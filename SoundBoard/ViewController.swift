//
//  ViewController.swift
//  SoundBoard
//
//  Created by KR DEVARAJAN NAIR on 2017/02/27.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    let records:[Record]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblView.delegate=self
        //tblView.dataSource=self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
}

