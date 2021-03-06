//
//  RepositoriesTableViewController.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: TableViewController<TwoLabelCell<Repository>> {
  
  var username: String? {
    didSet {
      guard let username = username, username.characters.count > 0 else { return }
      let fetch = APIClient<Repository>().fetchItems(forUser: username)
      fetch { (items, error) -> Void in
        self.title = username
        guard let theItems = items else { return }
        self.data = theItems.map { $0 }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let nextViewController = DetailViewController()
    nextViewController.repository = data[indexPath.row] //as? Repository
    navigationController?.pushViewController(nextViewController, animated: true)
  }
}
