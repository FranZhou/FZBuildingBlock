//
//  String+MD5.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/28.
//

import Foundation
import CommonCrypto

extension String{
    
    public enum CommonCryptoAlgorithm {
        case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
        
        var HMACAlgorithm: CCHmacAlgorithm {
            var result: Int = 0
            switch self {
            case .MD5:
                result = kCCHmacAlgMD5
            case .SHA1:
                result = kCCHmacAlgSHA1
            case .SHA224:
                result = kCCHmacAlgSHA224
            case .SHA256:
                result = kCCHmacAlgSHA256
            case .SHA384:
                result = kCCHmacAlgSHA384
            case .SHA512:
                result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }
        
        var digestLength: Int {
            var result: Int32 = 0
            switch self {
            case .MD5:
                result = CC_MD5_DIGEST_LENGTH
            case .SHA1:
                result = CC_SHA1_DIGEST_LENGTH
            case .SHA224:
                result = CC_SHA224_DIGEST_LENGTH
            case .SHA256:
                result = CC_SHA256_DIGEST_LENGTH
            case .SHA384:
                result = CC_SHA384_DIGEST_LENGTH
            case .SHA512:
                result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }
    }
    
    
    
    /// MD5
    public var fz_md5: String?{
        if let cStr = self.cString(using: .utf8){
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = CommonCryptoAlgorithm.MD5.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_MD5(cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
    
    /// SHA1
    public var fz_sha1: String?{
        if let cStr = self.cString(using: .utf8){
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = CommonCryptoAlgorithm.SHA1.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_SHA1(cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
    
    /// SHA224
    public var fz_sha224: String?{
        if let cStr = self.cString(using: .utf8){
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = CommonCryptoAlgorithm.SHA224.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_SHA224(cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
    
    /// SHA256
    public var fz_sha256: String?{
        if let cStr = self.cString(using: .utf8){
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = CommonCryptoAlgorithm.SHA256.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_SHA256(cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
    
    /// SHA384
    public var fz_sha384: String?{
        if let cStr = self.cString(using: .utf8){
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = CommonCryptoAlgorithm.SHA384.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_SHA384(cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
    
    /// SHA512
    public var fz_sha512: String?{
        if let cStr = self.cString(using: .utf8){
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = CommonCryptoAlgorithm.SHA512.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_SHA512(cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
    
    /// HMAC加密
    ///
    /// - Parameters:
    ///   - algorithm: 散列函数
    ///   - key: key
    /// - Returns:
    public func fz_hmac(algorithm: CommonCryptoAlgorithm, key: String) -> String?{
        if let cStr = self.cString(using: .utf8),
            let keyCStr = key.cString(using: .utf8){
            let strLen = Int(self.lengthOfBytes(using: .utf8))
            let keyLen = Int(key.lengthOfBytes(using: .utf8))
            let digestLen = algorithm.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CCHmac(algorithm.HMACAlgorithm, keyCStr, keyLen, cStr, strLen, result)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
        } else {
            return nil
        }
    }
    
}
