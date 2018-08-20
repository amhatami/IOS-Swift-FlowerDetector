//
//  Extentions.swift
//  IOS-Swift-FlowerDetector
//
//  Created by Pooya on 2018-05-29.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit

extension UIImage {
    
    func buffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer? = nil
        
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue:0))
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer!), width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: colorspace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)!
        
        bitmapContext.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return pixelBuffer
    }
}
