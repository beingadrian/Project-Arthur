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
    
    // MARK: - Properties
    
    @IBOutlet var mainView: ReportMainView!
    
    var viewModel: ReportViewModel!
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        HealthKitAPI().requestHealthKitPermissions()
//            .subscribeOn(MainScheduler.instance)
//            .subscribe(
//                onNext: { (success) -> Void in
//                    self.mainView.reportTableView.reloadData()
//                },
//                onError: { (error) -> Void in
//                    print("Error requesting error \(error)")
//                },
//                onCompleted: nil,
//                onDisposed: nil)
//            .addDisposableTo(disposeBag)
        
    }
    
    private func setup() {
        
        self.viewModel = ReportViewModel(owner: self)
        
        // table view setup
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
        
        return viewModel.cells.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = viewModel.cells[indexPath.row]
        
        return cell
        
    }
    
}
