
//  UliTool.swift
//  UliTool
//
//  Created by hub on 31.12.17.
//  Copyright © 2017 hub. All rights reserved.
//

import Foundation



public class UliTool
{
    var name: String
    var count: Int = 0;

    init( name: String){
        self.name = name
    }
    
    func increment(){
        count += 1
    }
    
    func increment(amount: Int){
        count += amount
    }
    
    func status(){
        print("Instance \(name) has current count \(count)")
    }
}
