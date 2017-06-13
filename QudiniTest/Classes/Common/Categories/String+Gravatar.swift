//
//  String+Gravatar.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation
extension String {
    
    static func gravatarURL(emailAddress: String?, size: Double) -> String {
        guard let emailAddress = emailAddress else {
            return String(format: NetworkConstants.gravatarPlaceholderURL, size)
        }
        
        return String(format: NetworkConstants.gravatarURL, String.emailHash(emailAddress), size)
    }
    
    static func emailHash(_ emailString: String) -> String {
        //1) Trim leading and trailing whitespace from an email address
        var curatedEmail = emailString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        //2) Force all characters to lower-case
        curatedEmail = curatedEmail.lowercased()
        
        //3) md5 hash the final string
        curatedEmail = String.md5(curatedEmail)
        
        return curatedEmail
    }
    
    static func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        
        return hexString
    }
    
}
