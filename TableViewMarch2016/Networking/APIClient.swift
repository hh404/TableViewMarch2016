//
//  APIClient.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

struct APIClient<T: DictCreatable> {
  
  func fetchItems(forUser userName: String) -> (_ completion: @escaping(_ items: [T]?, _ error: Error?) -> Void) -> Void {
    return { completion in
      
      guard let url = GithubURL.repositories(userName).url() else {
        let outputError = NSError(domain: "Invalid username", code: 111, userInfo: nil)
        completion(nil, outputError)
        return
      }
      
      let fetch = self.fetchItems(forURL: url)
      fetch(completion)
    }
  }
  
  func fetchUsers(forSearchString string: String) -> (_ completion: @escaping(_ items: [T]?, _ error: Error?) -> Void) -> Void {
    return { completion in
      
      guard let url = GithubURL.users(string).url() else {
        let outputError = NSError(domain: "Invalid search string", code: 111, userInfo: nil)
        completion(nil, outputError)
        return
      }
      
      let fetch = self.fetchItems(forURL: url, inDictionaryForKey: "items")
      fetch(completion)
    }
  }
  
  func fetchItems(forURL url: URL, inDictionaryForKey key: String? = nil) -> (_ completion:@escaping (_ items: [T]?, _ error: Error?) -> Void) -> Void {
    return { completion in
      var outputItems: [T]? = nil
      var outputError: Error? = nil
      
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let session = URLSession.shared
      session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
        
        defer {
          DispatchQueue.main.async(execute: { () -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completion(outputItems, outputError)
          })
        }
        
        outputError = error
        
        guard let data = data else { return }
        
        do {
          var itemArray: [[String: AnyObject]] = []
          if let key = key {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
              outputError = NSError(domain: "Invalid response", code: 112, userInfo: nil)
              return
            }
            guard let array = dict[key] as? [[String: AnyObject]] else {
              outputError = NSError(domain: "Invalid response", code: 112, userInfo: nil)
              return
            }
            itemArray = array
          } else {
            guard let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] else {
              outputError = NSError(domain: "Invalid response", code: 112, userInfo: nil)
              return
            }
            itemArray = array
          }
          
          var tempItems = [T]()
          for dict in itemArray {
            if let item = T(dict: dict as [NSObject : AnyObject]) {
              tempItems.append(item)
            }
          }
          outputItems = tempItems
          return
          
        } catch {
          outputError = error
        }
        
        }) .resume()
    }
  }
}
