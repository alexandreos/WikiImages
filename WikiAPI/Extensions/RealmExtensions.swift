//
//  RealmExtensions.swift
//  WikiImages
//
//  Created by Alexandre Santos on 20/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

import Foundation
import Realm

public extension RLMArray {
    public func toArray<T>(type: T.Type) -> [T] {
        var array = [T]()
        
        if self.count > 0 {
            for i in 0...self.count-1 {
                if let item = self.objectAtIndex(i) as? T {
                    array.append(item)
                }
            }
        }
        
        return array
    }
}

public extension RLMResults {
    public func toArray<T>(type: T.Type) -> [T] {
        var array = [T]()
        
        if self.count > 0 {
            for i in 0...self.count-1 {
                if let item = self.objectAtIndex(i) as? T {
                    array.append(item)
                }
            }
        }
        
        return array
    }
}