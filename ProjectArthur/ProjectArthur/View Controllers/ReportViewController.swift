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
    
    var viewModel: ReportViewModel!
    
    let alert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
    
    @IBAction func arthurButtonTapped(sender: UIButton) {
        guard let isHome = NSUserDefaults.standardUserDefaults().valueForKey("isHome") else {
            presentNoBeaconAlert()
            return
        }
        if isHome as! Bool {
            self.presentViewController(ArthurViewController(), animated: true, completion: nil)
        } else {
            presentNotHomeAlert()
        }
    }
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup() {
        
        self.viewModel = ReportViewModel()
        
        // table view setup
        self.mainView.reportTableView.delegate = self
        self.mainView.reportTableView.dataSource = self
        
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        
    }
    
    private func presentNoBeaconAlert() {
        alert.title = "Beacon not detected"
        alert.message = "Please set up a beacon and connect to it beforehand."
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func presentNotHomeAlert() {
        alert.title = "Arthur can only be opened while home"
        alert.message = "Please connect to your beacon."
        presentViewController(alert, animated: true, completion: nil)
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
        
        return viewModel.cards.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let nib = UINib(nibName: "WalkTableViewCell", bundle: nil)
        let cell = nib.instantiateWithOwner(self, options: nil).first as! WalkTableViewCell
        
        cell.card = viewModel.cards[indexPath.row]
        
        return cell
        
    }
    
}
