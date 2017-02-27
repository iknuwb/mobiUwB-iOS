//
//  MobiUwbModel.swift
//
//
//  Created by Grzegorz Szymański on 13.08.2015.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

import Foundation

class MobiUwbModel: NSObject {
    let data: String
    let tresc: String
    let tytul: String
    
    override var description: String {
        return "Data: \(data), \n Treść: \(tresc) \n Tytul: \(tytul) "
    }
    
    init(data: String?, tresc: String?, tytul: String?) {
        self.data = data ?? ""
        self.tresc = tresc ?? ""
        self.tytul = tytul ?? ""
    }
}