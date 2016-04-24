//
//  DlgSelectImgSource.swift
//  Jike
//
//  Created by Iosmac on 15/5/25.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol DlgSelectImgSourceDelegate {

    func imgPicked(img:[UIImage])

}

//选取照片的控件
class DlgSelectImgSource:NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate
{

   weak var parentVC:UIViewController!
    var delegate:DlgSelectImgSourceDelegate!
    var isSingleSelect:Bool = true
    var maxNumIfIsMutiSelect:Int = 10

    //对于编辑个人头像的特殊处理
    var isFromEditInfo:Bool = false

    init(vc:UIViewController, dele:DlgSelectImgSourceDelegate, isSingleSelect:Bool, maxNumIfIsMutiSelect:Int?) {
        self.parentVC = vc
        self.delegate = dele
        self.isSingleSelect = isSingleSelect
        if(maxNumIfIsMutiSelect != nil) {
            self.maxNumIfIsMutiSelect = maxNumIfIsMutiSelect!
        }
    }

    func showDlg() {
        showDogWithTitle(nil)
    }

    func showDogWithTitle(title:String?) {
        let actionSheetView = UIActionSheet(title: title, delegate: self, cancelButtonTitle: nil,
                                            destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选择", "取消")
        actionSheetView.destructiveButtonIndex = 3
        if (self.parentVC.view != nil)
        {
            actionSheetView.showInView(self.parentVC.view)
        }
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        LogUtils.log("actionSheet():buttonIndex=\(buttonIndex)")
        if (buttonIndex == 0) {
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(imagePicker.sourceType)!
                imagePicker.delegate = self
                imagePicker.allowsEditing = self.isFromEditInfo
                self.parentVC.presentViewController(imagePicker, animated: true, completion: nil)
            } else {
                LogUtils.log("相机不可用")
            }
        }

        if (buttonIndex == 1) {
            if (isFromEditInfo)
            {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(imagePicker.sourceType)!
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                parentVC.presentViewController(imagePicker, animated: true, completion: nil)
            }
            else
            {
              if(isSingleSelect) {
                let pickerSingle = ZYQAssetPickerController()
                pickerSingle.maximumNumberOfSelection = 1
                pickerSingle.assetsFilter = ALAssetsFilter()
                pickerSingle.showEmptyGroups = false
                pickerSingle.delegate = self

                parentVC.presentViewController(pickerSingle, animated: false, completion: nil)

            }else {
                let picker = ZYQAssetPickerController()
                picker.maximumNumberOfSelection = self.maxNumIfIsMutiSelect
                picker.assetsFilter = ALAssetsFilter()
                picker.showEmptyGroups = false
                picker.delegate = self

                parentVC.presentViewController(picker, animated: false, completion: nil)
            }
            }
        }
        LogUtils.log("actionSheet()")
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

//        var test: AnyObject? = info[UIImagePickerControllerMediaType]

        var image:UIImage?

        if picker.allowsEditing {
            image = info[UIImagePickerControllerEditedImage] as? UIImage
        }
        else{
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }

        parentVC.dismissViewControllerAnimated(false, completion: nil)

        if(image != nil) {
            self.delegate.imgPicked([image!])
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

//        var test: AnyObject? = editingInfo[UIImagePickerControllerMediaType]

        var image:UIImage!

        if picker.allowsEditing {
            image = editingInfo[UIImagePickerControllerEditedImage] as! UIImage
        }
        else{
            image = editingInfo[UIImagePickerControllerOriginalImage] as! UIImage
        }

        parentVC.dismissViewControllerAnimated(false, completion: nil)
        self.delegate.imgPicked([image])
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {

        parentVC.dismissViewControllerAnimated(false, completion: nil)
    }
   
   func assetPickerController(picker: ZYQAssetPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
    
        var imgArr = Array<UIImage>()
        for a in assets {
            let asset:ALAsset? = a as? ALAsset
            let cgimage = asset?.defaultRepresentation().fullScreenImage().takeUnretainedValue()
            if (cgimage != nil)
            {
                let img:UIImage? = UIImage(CGImage:cgimage!)
                if (img != nil)
                {
                    imgArr.append(img!)
                    LogUtils.log("assetPickerController():img?.size.width=\(img!.size.width)")
                }
            }
            
        }
        
        if(imgArr.count>0){
            self.delegate.imgPicked(imgArr)
        }
    }
    
    
}