//
//  KeyPair.swift
//  integration_test
//
//  Created by prongbang on 13/9/2566 BE.
//

import Foundation
import Sodium

public struct KeyPair {
    let pk: Bytes
    let sk: Bytes
    
    public init(pk: Bytes, sk: Bytes) {
        self.pk = pk
        self.sk = sk
    }
    
}
