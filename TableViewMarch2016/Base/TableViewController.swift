//
//  TableViewController.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class TableViewController<Cell: UITableViewCell>: UITableViewController where Cell: Configurable {
  typealias DataType = Cell.DataType
  fileprivate let cellIdentifier = String(describing: Cell())
  var data = [DataType]() {
    didSet {
      tableView.reloadData()
      if tableView.numberOfRows(inSection: 0) > 0 {
        tableView.scrollToRow(at: IndexPath(row: 0,section: 0),
                                         at: .top,
                                         animated: true)
      }
    }
  }
  
  init() { super.init(nibName: nil, bundle: nil) }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                           for: indexPath) as! Cell
    cell.config(withItem: data[indexPath.row])
    return cell
  }
}
