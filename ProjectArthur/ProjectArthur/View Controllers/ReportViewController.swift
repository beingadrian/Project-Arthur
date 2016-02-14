//
//  ReportViewController.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var mainView: ReportMainView!
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup() {
        
        self.mainView.reportTableView.delegate = self
        self.mainView.reportTableView.dataSource = self
        
    }
    
}

extension ReportViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return nil
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 220
        
    }
    
}

extension ReportViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let nib = UINib(nibName: "WalkTableViewCell", bundle: nil)
        let cell = nib.instantiateWithOwner(self, options: nil).first as! WalkTableViewCell
        
        return cell
        
    }
    
}
