//
//  FileInput.swift
//  Testaty
//
//  Created by Hesham Donia on 21/09/2022.
//

import UIKit

enum MediaError: Error {
    case runtimeError(String)
}

struct FileInput: Encodable {
    
    var key: String
    var filename: String?
    var data: Data
    var mimeType: String
    var tag: String?
    
    init?(with data: Data, forKey key: String, fileName:String?, mimeType: String) {
        self.key = key
        self.mimeType = mimeType
        self.filename = fileName
        self.data = data
    }
    
    init?(withFile url: URL, forKey key: String, fileName:String?, mimeType: String) throws {
        do {
            let data = try Data(contentsOf: url)
            self.data = data
        } catch {
            throw MediaError.runtimeError("can't load data from URL")
        }
        self.key = key
        self.mimeType = mimeType
        self.filename = fileName
    }
}

