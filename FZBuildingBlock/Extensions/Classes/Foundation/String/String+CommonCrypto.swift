//
//  String+MD5.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/28.
//

import Foundation
import CommonCrypto



// MARK: - MD5, SHA1, SHA224, SHA256, SHA384, SHA512
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
            defer{
                result.deallocate()
            }
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
            defer{
                result.deallocate()
            }
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
            defer{
                result.deallocate()
            }
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
            defer{
                result.deallocate()
            }
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
            defer{
                result.deallocate()
            }
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
            defer{
                result.deallocate()
            }
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
    
}


// MARK: - HMAC
extension String{
    
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
            defer{
                result.deallocate()
            }
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



// MARK: - 文件加密
extension String{
    
    
    /// 计算文件 MD5
    ///
    /// - Parameter filePath: filePath
    /// - Returns: MD5 string
    public static func fz_md5(OfFile filePath: String) -> String?{
        if let fileHandle = FileHandle(forReadingAtPath: filePath) {
            let ctx = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: MemoryLayout<CC_MD5_CTX>.size)
            defer{
                ctx.deallocate()
                fileHandle.closeFile()
            }
            CC_MD5_Init(ctx)
            
            var done = false
            let bufferSize = 1024 * 1024
            while !done {
                var fileData = fileHandle.readData(ofLength: bufferSize)
                let count = fileData.count
                
                #if swift(>=5.0)
                fileData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) -> (Void) in
                    if let rawPointer = pointer.baseAddress{
                        let bytes = UnsafePointer<CChar>.init(OpaquePointer(rawPointer))
                        CC_MD5_Update(ctx, bytes, CC_LONG(count))
                    }
                }
                #else
                fileData.withUnsafeBytes{(bytes: UnsafePointer<CChar>) -> (Void) in
                    CC_MD5_Update(ctx, bytes, CC_LONG(fileData.count))
                }
                #endif

                if count == 0 {
                    done = true
                }
            }
            
            let digestLen = CommonCryptoAlgorithm.MD5.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            defer{
                result.deallocate()
            }
            CC_MD5_Final(result, ctx)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
            
        }
        return nil
    }
    
    
    /// 计算文件 SHA1
    ///
    /// - Parameter filePath: filePath
    /// - Returns: SHA1 string
    public static func fz_sha1(OfFile filePath: String) -> String?{
        if let fileHandle = FileHandle(forReadingAtPath: filePath) {
            let ctx = UnsafeMutablePointer<CC_SHA1_CTX>.allocate(capacity: MemoryLayout<CC_SHA1_CTX>.size)
            defer{
                ctx.deallocate()
                fileHandle.closeFile()
            }
            CC_SHA1_Init(ctx)
            
            var done = false
            let bufferSize = 1024 * 1024
            while !done {
                var fileData = fileHandle.readData(ofLength: bufferSize)
                let count = fileData.count
                
                #if swift(>=5.0)
                fileData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) -> (Void) in
                    if let rawPointer = pointer.baseAddress{
                        let bytes = UnsafePointer<CChar>.init(OpaquePointer(rawPointer))
                        CC_SHA1_Update(ctx,  bytes, CC_LONG(count))
                    }
                }
                #else
                fileData.withUnsafeBytes{(bytes: UnsafePointer<CChar>) -> (Void) in
                    CC_SHA1_Update(ctx, bytes, CC_LONG(fileData.count))
                }
                #endif
                
                if count == 0 {
                    done = true
                }
            }
            
            let digestLen = CommonCryptoAlgorithm.SHA1.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            defer{
                result.deallocate()
            }
            CC_SHA1_Final(result, ctx)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
            
        }
        return nil
    }
    
    /// 计算文件 SHA256
    ///
    /// - Parameter filePath: filePath
    /// - Returns: SHA256 string
    public static func fz_sha256(OfFile filePath: String) -> String?{
        if let fileHandle = FileHandle(forReadingAtPath: filePath) {
            let ctx = UnsafeMutablePointer<CC_SHA256_CTX>.allocate(capacity: MemoryLayout<CC_SHA256_CTX>.size)
            defer{
                ctx.deallocate()
                fileHandle.closeFile()
            }
            CC_SHA256_Init(ctx)
            
            var done = false
            let bufferSize = 1024 * 1024
            while !done {
                var fileData = fileHandle.readData(ofLength: bufferSize)
                let count = fileData.count
                
                #if swift(>=5.0)
                fileData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) -> (Void) in
                    if let rawPointer = pointer.baseAddress{
                        let bytes = UnsafePointer<CChar>.init(OpaquePointer(rawPointer))
                        CC_SHA256_Update(ctx, bytes, CC_LONG(count))
                    }
                }
                #else
                fileData.withUnsafeBytes{(bytes: UnsafePointer<CChar>) -> (Void) in
                    CC_SHA256_Update(ctx, bytes, CC_LONG(fileData.count))
                }
                #endif
                
                if count == 0 {
                    done = true
                }
            }
            
            let digestLen = CommonCryptoAlgorithm.SHA1.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            defer{
                result.deallocate()
            }
            CC_SHA256_Final(result, ctx)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
            
        }
        return nil
    }
    
    /// 计算文件 SHA512
    ///
    /// - Parameter filePath: filePath
    /// - Returns: SHA512 string
    public static func fz_sha512(OfFile filePath: String) -> String?{
        if let fileHandle = FileHandle(forReadingAtPath: filePath) {
            let ctx = UnsafeMutablePointer<CC_SHA512_CTX>.allocate(capacity: MemoryLayout<CC_SHA512_CTX>.size)
            defer{
                ctx.deallocate()
                fileHandle.closeFile()
            }
            CC_SHA512_Init(ctx)
            
            var done = false
            let bufferSize = 1024 * 1024
            while !done {
                var fileData = fileHandle.readData(ofLength: bufferSize)
                let count = fileData.count
                
                #if swift(>=5.0)
                fileData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) -> (Void) in
                    if let rawPointer = pointer.baseAddress{
                        let bytes = UnsafePointer<CChar>.init(OpaquePointer(rawPointer))
                        CC_SHA512_Update(ctx, bytes, CC_LONG(count))
                    }
                }
                #else
                fileData.withUnsafeBytes{(bytes: UnsafePointer<CChar>) -> (Void) in
                    CC_SHA512_Update(ctx, bytes, CC_LONG(fileData.count))
                }
                #endif
                
                if count == 0 {
                    done = true
                }
            }
            
            let digestLen = CommonCryptoAlgorithm.SHA1.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            defer{
                result.deallocate()
            }
            CC_SHA512_Final(result, ctx)
            
            let output = NSMutableString()
            for i in 0..<digestLen {
                output.appendFormat("%02x", result[i])
            }
            
            return String(output)
            
        }
        return nil
    }
    
    
    /// 计算文件 HMAC
    ///
    /// - Parameters:
    ///   - filePath: filePath
    ///   - algorithm: 散列函数
    ///   - key: key
    /// - Returns: HMAC string
    public static func fz_hmac(OfFile filePath: String, algorithm: CommonCryptoAlgorithm, key: String) -> String?{
        if let fileHandle = FileHandle(forReadingAtPath: filePath),
            let keyCStr = key.cString(using: .utf8) {
            let keyLen = Int(key.lengthOfBytes(using: .utf8))
            let ctx = UnsafeMutablePointer<CCHmacContext>.allocate(capacity: MemoryLayout<CCHmacContext>.size)
            defer{
                ctx.deallocate()
                fileHandle.closeFile()
            }
            CCHmacInit(ctx, algorithm.HMACAlgorithm, keyCStr, keyLen)
            
            var done = false
            let bufferSize = 1024 * 1024
            while !done {
                var fileData = fileHandle.readData(ofLength: bufferSize)
                let count = fileData.count
                
                #if swift(>=5.0)
                fileData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) -> (Void) in
                    if let rawPointer = pointer.baseAddress{
                        let bytes = UnsafePointer<CChar>.init(OpaquePointer(rawPointer))
                        CCHmacUpdate(ctx, bytes, count)
                    }
                }
                #else
                fileData.withUnsafeBytes{(bytes: UnsafePointer<CChar>) -> (Void) in
                    CCHmacUpdate(ctx, bytes, count)
                }
                #endif
                
                if count == 0 {
                    done = true
                }
            }
            
            let digestLen = algorithm.digestLength
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            defer{
                result.deallocate()
            }
            CCHmacFinal(ctx, UnsafeMutableRawPointer(mutating: result))
            
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
