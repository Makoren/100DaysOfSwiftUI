//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Luke Lazzaro on 21/11/21.
//

import Foundation
import UIKit

/// This class wraps the UIImageWriteToSavedPhotosAlbum method so that we don't have to use old Objective-C code outside of this class.
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
