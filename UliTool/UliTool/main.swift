//
//  main.swift
//  UliTool
//
//  Created by hub on 31.12.17.
//  Copyright © 2017 hub. All rights reserved.
//

import Foundation

print("Hello, World!")


var uliTool: UliTool = UliTool( name:"inschtanz eis")

uliTool.increment()
uliTool.status()

uliTool.increment(amount: 12)
uliTool.status()

uliTool.increment()
uliTool.status()

