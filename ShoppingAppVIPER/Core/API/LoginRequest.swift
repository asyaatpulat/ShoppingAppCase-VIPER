//
//  LoginRequest.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}
