//
//  DDHKeychain.swift
//  KeychainDemo
//
//  Created by dasdom on 10.08.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import Foundation

public class DDHKeychain {
    
    private class func secClassGenericPassword() -> String {
        return kSecClassGenericPassword.takeRetainedValue() as String
    }
    
    private class func secClass() -> String {
        return kSecClass.takeRetainedValue() as String
    }
    
    private class func secAttrService() -> String {
        return kSecAttrService.takeRetainedValue() as String
    }
    
    private class func secAttrAccount() -> String {
        return kSecAttrAccount.takeRetainedValue() as String
    }
    
    private class func secValueData() -> String {
        return kSecValueData.takeRetainedValue() as String
    }
    
    private class func secReturnData() -> String {
        return kSecReturnData.takeRetainedValue() as String
    }
    
    public class func setPassword(password: String, account: String, service: String = "kDDHDefaultService") {
        var secret: NSData = password.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        //        let kSecClassGenericPasswordSwift: String = kSecClassGenericPassword.takeRetainedValue() as String
        let objects: Array = [secClassGenericPassword(), service, account, secret]
        
        //        let kSecClassSwift: NSString = kSecClass.takeRetainedValue() as NSString
        //        let kSecAttrServiceSwift: NSString = kSecAttrService.takeRetainedValue() as NSString
        //        let kSecAttrAccountSwift: NSString = kSecAttrAccount.takeRetainedValue() as NSString
        //        let kSecValueDataSwift: NSString = kSecValueData.takeRetainedValue() as NSString
        let keys: Array = [secClass(), secAttrService(), secAttrAccount(), secValueData()]
        
        let query = NSDictionary(objects: objects, forKeys: keys)
        
        SecItemDelete(query as CFDictionaryRef)
        
        let status = SecItemAdd(query as CFDictionaryRef, nil)
    }
    
    public class func passwordForAccount(account: String, service: String = "kDDHDefaultService") -> String {
        
        let queryAttributes = NSDictionary(objects: [secClassGenericPassword(), service, account, true], forKeys: [secClass(), secAttrService(), secAttrAccount(), secReturnData()])
        
        
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var dataTypeRef : Unmanaged<AnyObject>?
            let status = SecItemCopyMatching(queryAttributes, &dataTypeRef);
            
            let retrievedData : NSData = dataTypeRef!.takeRetainedValue() as NSData
            
            let password = NSString(data: retrievedData, encoding: NSUTF8StringEncoding)
            
            return password as String
//        })
        
//        return nil
    }
    
}