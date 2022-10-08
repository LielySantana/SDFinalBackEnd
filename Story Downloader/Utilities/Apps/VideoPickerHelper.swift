//
//  VideoPickerHelper.swift
//  Agafos
//
//  Created by Shubham Kaliyar on 12/10/17.
//  Copyright © 2017 Tahir. All rights reserved.
//


var PickerVideoCallBack:PickerVideo = nil
typealias PickerVideo = ((VideoData?) -> (Void))?
let videoPickerInstanse = VideoPickerHelper.shared

import UIKit
import AVFoundation
import MobileCoreServices

class VideoPickerHelper: NSObject {
    
    private override init() {
        
    }
    static var shared : VideoPickerHelper = VideoPickerHelper()
    var picker = UIImagePickerController()
    var referense:UIViewController?
    
    // MARK:- Action Sheet
    func showActionSheet(referense:UIViewController, withTitle title: String?, withAlertMessage message: String?, withOptions options: [String], handler:@escaping (_ selectedIndex: Int) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for strAction in options {
            let anyAction =  UIAlertAction(title: strAction, style: .default){ (action) -> Void in
                return handler(options.firstIndex(of: strAction)!)
            }
            alert.addAction(anyAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) -> Void in
            return handler(-1)
        }
        alert.view.tintColor = #colorLiteral(red: 0.8133832216, green: 0.1112861112, blue: 0, alpha: 1)
        alert.addAction(cancelAction)
        presetImagePicker(pickerVC: alert, referense: referense)
        
    }
    
    // MARK: Public Method
    func showVideoController(referense: UIViewController ,_ handler:PickerVideo) {
        self.showActionSheet(referense: referense, withTitle: "Choose Option", withAlertMessage: nil, withOptions: ["Take Video", "Open Gallery"]){ ( _ selectedIndex: Int) in
            switch selectedIndex {
            case OpenMediaType.camera.rawValue:
                self.showCamera(referense: referense)
            case OpenMediaType.photoLibrary.rawValue:
                self.openGallery(referense: referense)
            default:
                break
            }
        }
        PickerVideoCallBack = handler
    }
    
    // MARK:-  Camera
    func showCamera(referense: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.delegate = self
            picker.sourceType = .camera
            picker.videoMaximumDuration = 10
            picker.mediaTypes = [kUTTypeMovie] as [String]
            presetImagePicker(pickerVC: picker, referense: referense)
        } else {
            CommonUtils.showToast(message: "Camera not available.")
        }
        picker.delegate = self
    }
    
    // MARK:-  Camera
    func showCamera(referense :UIViewController ,_ handler:PickerVideo) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.delegate = self
            picker.videoQuality = .typeHigh
            picker.sourceType = .camera
            picker.mediaTypes = [kUTTypeMovie] as [String]
            presetImagePicker(pickerVC: picker, referense: referense)
        } else {
            CommonUtils.showToast(message: "Camera not available.")
        }
        picker.delegate = self
        PickerVideoCallBack = handler
    }
    
    // MARK:-  Gallery
    
    func openGallery(referense: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie] as [String]
        presetImagePicker(pickerVC: picker, referense: referense)
        picker.delegate = self
    }
    
    // MARK:- Show ViewController
    
    private func presetImagePicker(pickerVC: UIViewController , referense: UIViewController) -> Void {
        self.referense = referense
        self.referense?.present(pickerVC, animated: true, completion: {
            self.picker.delegate = self
        })
    }
    
    fileprivate func dismissViewController() -> Void {
        self.referense?.dismiss(animated: false, completion: nil)
    }
    
    func thumbnailForVideoAtURL(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("Place holder not get")
            return #imageLiteral(resourceName: "play")
        }
    }
    
    func thumbnil(url: URL , completionClosure: @escaping (_ result: UIImage?) -> ()) {
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        var time = asset.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            completionClosure(UIImage(cgImage: imageRef))
        } catch {
            completionClosure(#imageLiteral(resourceName: "play"))
            print("Place holder  get")
        }
    }
}

// MARK: - Picker Delegate
extension VideoPickerHelper : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
        print("Shubham Kaliyar")
        
        guard let Url = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
        print(Url.lastPathComponent)
        let videoFile = AVAsset(url: Url)
        let videoData = try? Data.init(contentsOf: Url)
        var video = VideoData()
        video.videoUrl = Url
        video.thumbnilImage = self.thumbnailForVideoAtURL(url: Url)
        video.videoData = videoData ?? Data()
        video.videoTime = CMTimeGetSeconds(videoFile.duration)
        PickerVideoCallBack?(video)
        dismissViewController()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissViewController()
    }
}

class VideoData {
    var thumbnilImage:UIImage?
    var videoUrl:URL?
    var videoData:Data?
    var videoTime:Float64?
    init() {  }
    
}
