//
//  ReportViewController.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit
import RxSwift

class ReportViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    let realmHelper = RealmReportHelper()
    
    // MARK: - Properties
    
    @IBOutlet var mainView: ReportMainView!
    
    var viewModel: ReportViewModel!
    
    let alert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
    
    @IBAction func arthurButtonTapped(sender: UIButton) {
        
        // For demo purposes -> Allow connection to Arthur at any time
        
//        guard let isHome = NSUserDefaults.standardUserDefaults().valueForKey("isHome") else {
//            presentNoBeaconAlert()
//            return
//        }
//        if isHome as! Bool == true {
//            let storyboard = UIStoryboard(name: "Arthur", bundle: NSBundle.mainBundle())
//            let vc = storyboard.instantiateInitialViewController()
//            self.presentViewController(vc!, animated: true, completion: nil)
//        } else {
//            presentNotHomeAlert()
//        }
        
        let storyboard = UIStoryboard(name: "Arthur", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateInitialViewController()
        self.presentViewController(vc!, animated: true, completion: nil)
    }
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        HealthKitAPI().requestHealthKitPermissions()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (success) -> Void in
                    self.mainView.reportTableView.reloadData()
                },
                onError: { (error) -> Void in
                    print("Error requesting error \(error)")
                },
                onCompleted: nil,
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
        RemindersAPI().requestAccessToReminders()
            .subscribe(
                onNext: { (success) -> Void in
                    print("Success: \(success)")
                },
                onError: { (error) -> Void in
                    print("Error requesting error \(error)")
                },
                onCompleted: nil,
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
        
        
    }
    
    private func setup() {
        
        self.viewModel = ReportViewModel(owner: self)
        
        realmHelper.prepareForReportGeneration()
        
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
        
        return viewModel.cells.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = viewModel.cells[indexPath.row]
        
        if let cel = cell as? LazyLoader {
            cel.onCompletedLoadingData
                .observeOn(MainScheduler.instance)
                .subscribeNext {
                    self.mainView.reportTableView.reloadData()
                }
                .addDisposableTo(disposeBag)
        }
        
        return cell
        
    }
    
}

extension ReportViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        mainView.moveBgByOffset(scrollView.contentOffset.y)

        
    }
}
