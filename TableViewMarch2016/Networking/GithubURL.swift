//
//  GithubURL.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

enum GithubURL {
  case repositories(String)
  case users(String)
  
  var baseURLString: String { return "https://api.github.com" }
  
  func url() -> URL? {
    switch self {
    case .repositories(let user):
      return URL(string: "\(baseURLString)/users/\(user)/repos")
    case .users(let searchString):
      guard let encodedSearchString = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return nil }
      return URL(string: "\(baseURLString)/search/users?q=\(encodedSearchString)")
    }
  }
}
