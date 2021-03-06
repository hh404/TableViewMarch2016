//
//  UserSearchTableViewController.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class UserSearchTableViewController: TableViewController<TwoLabelCell<User>>, UISearchBarDelegate {
  
  var searchString: String? {
    didSet {
      guard let searchString = searchString, searchString.characters.count > 0 else { return }
      let fetch = APIClient<User>().fetchUsers(forSearchString: searchString)
      fetch { (items, error) -> Void in
        guard let theItems = items else { return }
        self.data = theItems.map { $0 }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "User"
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
    searchBar.placeholder = "Github username"
    searchBar.delegate = self
    tableView.tableHeaderView = searchBar
  }
  
  @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchString = searchBar.text
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let next = RepositoriesTableViewController()
    next.username = self.data[indexPath.row].name
    navigationController?.pushViewController(next, animated: true)
    
  }
}
