//
//  Request.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
}

struct Request: RequestProtocol {
    var baseURL: String
    var path: String
    var method: RequestMethod
}
