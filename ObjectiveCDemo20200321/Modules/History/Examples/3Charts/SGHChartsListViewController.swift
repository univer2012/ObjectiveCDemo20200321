//
//  SGHChartsListViewController.swift
//  ObjectiveCDemo20200321
//
//  Created by blue on 2020/6/2.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SGHChartsListViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.type = .newVC

        //MARK: section 1
        let tempTitleArray = [
            "1.LineChartView的一个例子",
        ]
        let tempSelectorArray = [
            "SGHLineChartViewController",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray, titleArray: tempTitleArray, title: "swift")
        
        self.tableView.reloadData()
    }
    
    

}
