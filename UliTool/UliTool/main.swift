//
//  main.swift
//  UliTool
//
//  Created by hub on 31.12.17.
//  Copyright © 2017 hub. All rights reserved.
//

import Foundation


var uliTool: UliTool = UliTool(name:"UliToolNumeroUnohal")

uliTool.increment()
uliTool.status()

uliTool.increment(amount: 12)
uliTool.status()

uliTool.increment()
uliTool.status()

uliTool.decrement(amount: 100)
uliTool.status()
