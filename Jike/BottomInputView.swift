//
//  BottomInputView.swift
//  Jike
//
//  Created by Iosmac on 15/6/20.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


@objc protocol BottomInputViewDelegate {

    func sendText(text:String)
    optional func sendImg(img:UIImage)
    optional func disableUserSendMessage()

    optional func sendVoice(filePath:String)

    optional func keyBoardOpenClose(isOpend:Bool, keyBoardHeight:CGFloat)
    optional func exchangeKeyBoard()
}

//封装的输入框，用在评论聊天等界面。这里面已经集成了emoji
class BottomInputView: UIView, DlgSelectImgSourceDelegate,UITextViewDelegate, EmojiKeyBoardViewDelegate {

    enum ShowType {
        case OnlyText
        case EmojiText
        case ImgEmojiText
    }

   weak var delegate:BottomInputViewDelegate!
    var dlg:DlgSelectImgSource!

    var selectVoiceBtn:UIButton!
    var selectImgBtn:UIButton!
    var selectEmojiBtn:UIButton!
    var myInputView:UITextField!

    var speakBtn:UIButton!

    var emojiBoard:EmojiKeyBoardView!

    let padding = UISettings.common_table_padding
    let baseHeight:CGFloat = 44
    let baseWidth = UiUtils.getBaseWidth()

    var originY:CGFloat!

    var isKeyBoardShowing = false

    var recordHelp = AudioHelper()
    init(x:CGFloat, maxY:CGFloat, type:ShowType) {
        super.init(frame: CGRectMake(x, maxY-baseHeight, baseWidth, baseHeight))

        self.backgroundColor = Color.common_text_bg_color

        self.layer.addSublayer(UiUtils.createDividerLine(0, y: 0, width: self.frame.width))

        self.originY = maxY-baseHeight

        emojiBoard = EmojiKeyBoardView(x: 0, y: baseHeight)
        emojiBoard.delegate = self

        selectVoiceBtn = UIButton(frame: CGRectMake(0, 0, baseHeight, baseHeight))
        selectVoiceBtn.setImage(UIImage(named: "chat_msg_send_voice_button_bg_normal"), forState: UIControlState.Normal)
        selectVoiceBtn.setImage(UIImage(named: "chat_msg_send_text_button_bg_normal"), forState: UIControlState.Selected)
        selectVoiceBtn.setImage(UIImage(named: "chat_msg_send_text_button_bg_normal"), forState: UIControlState.Highlighted)

        selectImgBtn = UIButton(frame: CGRectMake(baseWidth-baseHeight, 0, baseHeight, baseHeight))
        selectImgBtn.setImage(UIImage(named: "chat_msg_send_img_button_bg_normal"), forState: UIControlState.Normal)

        selectEmojiBtn = UIButton(frame: CGRectMake(baseWidth-baseHeight*2, 0, baseHeight, baseHeight))
        selectEmojiBtn.setImage(UIImage(named: "chat_msg_send_emoji_button_bg_normal"), forState: UIControlState.Normal)
        selectEmojiBtn.setImage(UIImage(named: "chat_msg_send_text_button_bg_normal"), forState: UIControlState.Selected)
        selectEmojiBtn.setImage(UIImage(named: "chat_msg_send_text_button_bg_normal"), forState: UIControlState.Highlighted)

        myInputView = UITextField(frame: CGRectMake(selectVoiceBtn.frame.maxX, padding, baseWidth-baseHeight*3,
                                                   baseHeight-padding*2))
        myInputView.layer.cornerRadius = UISettings.common_corner_size
        myInputView.layer.masksToBounds = true
        myInputView.layer.borderWidth = UISettings.common_line_height
        myInputView.layer.borderColor = Color.common_line_color.CGColor        
        myInputView.textColor = Color.common_text_color_black
        myInputView.font = UISettings.getFont(UISettings.common_label_content_font)
        myInputView.keyboardType = UIKeyboardType.Default
        myInputView.returnKeyType = UIReturnKeyType.Send
        myInputView.backgroundColor = Color.common_page_bg_color

        speakBtn = UIButton(frame: CGRectMake(0, 0, baseWidth, baseHeight))
        speakBtn.setBackgroundImage(UiUtils.getImageWithColor(Color.styleColor,
                                    size: CGSize(width: baseWidth, height: baseHeight)),
                                    forState: UIControlState.Normal)
        speakBtn.setTitle("按 住 说 话", forState: UIControlState.Normal)
        speakBtn.setTitle("松 开 发 送", forState: UIControlState.Highlighted)
        speakBtn.setTitle("松 开 发 送", forState: UIControlState.Selected)
        speakBtn.setTitleColor(Color.white, forState: UIControlState.Normal)
        speakBtn.titleLabel?.font = UISettings.getFont(UISettings.common_label_content_font)
        speakBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        speakBtn.addTarget(self, action: "speckBtnDown", forControlEvents: UIControlEvents.TouchDown)
        speakBtn.addTarget(self, action: "speckBtnUp", forControlEvents: UIControlEvents.TouchUpInside)

        emojiBoard.inputViewOutSide=myInputView

        selectVoiceBtn.addTarget(self, action: "selectVoiceClicked", forControlEvents: UIControlEvents.TouchUpInside)
        selectImgBtn.addTarget(self, action: "selectImgClicked", forControlEvents: UIControlEvents.TouchUpInside)
        selectEmojiBtn.addTarget(self, action: "selectEmojiClicked", forControlEvents: UIControlEvents.TouchUpInside)

        selectImgBtn.enabled = false
        selectEmojiBtn.enabled = false

        self.addSubview(myInputView)

        if(type == ShowType.OnlyText) {

            myInputView.frame = CGRectMake(padding*2, myInputView.frame.origin.y,
                                           baseWidth-padding*3*2, myInputView.frame.height)
        }
        else if(type == ShowType.EmojiText) {

            self.addSubview(selectEmojiBtn)

            selectEmojiBtn.frame.origin.x = baseWidth-baseHeight

            myInputView.frame = CGRectMake(padding*2, myInputView.frame.origin.y,
                                           baseWidth-baseHeight-padding*2, myInputView.frame.height)

            dlg = DlgSelectImgSource(vc: UiUtils.getCurrentVC(), dele: self, isSingleSelect: true, maxNumIfIsMutiSelect:nil)
        }
        else if(type == ShowType.ImgEmojiText) {

            selectEmojiBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: padding*2, bottom: 0, right: 0)

            self.addSubview(selectVoiceBtn)
            self.addSubview(selectImgBtn)
            self.addSubview(selectEmojiBtn)

            selectVoiceBtn.frame.origin.x = 0
            selectImgBtn.frame.origin.x = baseWidth - selectImgBtn.frame.width
            selectEmojiBtn.frame.origin.x = selectImgBtn.frame.origin.x-selectEmojiBtn.frame.width

            myInputView.frame = CGRectMake(selectVoiceBtn.frame.maxX, myInputView.frame.origin.y,
                                           baseWidth-baseHeight*3, myInputView.frame.height)

            speakBtn.center.x = myInputView.frame.width/2
            speakBtn.center.y = myInputView.frame.height/2

            dlg = DlgSelectImgSource(vc: UiUtils.getCurrentVC(), dele: self, isSingleSelect: true, maxNumIfIsMutiSelect:nil)
        }

        setMoveViewsWithKeyBoardEnabled()
    }

    func setPlaceHolder(holder:String) {
        self.myInputView.placeholder = holder
    }

    func showKeyBoard() {
        self.myInputView.becomeFirstResponder()
    }

    func setSendButtonEnable(enabled:Bool) {
        self.selectImgBtn.enabled = enabled
        self.selectEmojiBtn.enabled = enabled
    }

    private func isInSpeckMode() -> Bool {
        let subs = myInputView.subviews
        for sub in subs {
            if(sub is UIButton) {
                return true
            }
        }
        return false
    }

    func selectVoiceClicked() {
        if(isInSpeckMode()) {
            speakBtn.removeFromSuperview()
            selectVoiceBtn.selected = false
            showKeyBoard()
        }
        else {
            closeKeyBoard()
            myInputView.addSubview(speakBtn)
            selectVoiceBtn.selected = true
        }
        self.selectEmojiBtn.selected = false
    }

    var isLastRecordSuc:Bool = false

    func speckBtnDown() {
        isLastRecordSuc = recordHelp.record()
        LogUtils.log("speckBtnDown():isLastRecordSuc=\(isLastRecordSuc)")
    }

    func speckBtnUp() {
        if(isLastRecordSuc) {
            delegate.sendVoice?(recordHelp.stopAndGetFile())
        }
        LogUtils.log("speckBtnUp():isLastRecordSuc=\(isLastRecordSuc)")
    }

    func selectImgClicked() {
        self.selectEmojiBtn.selected = false
        dlg.showDlg()
    }

    func selectEmojiClicked() {
        self.delegate.exchangeKeyBoard?()
        self.speakBtn.removeFromSuperview()
        self.selectVoiceBtn.selected = false

        if(isEmojiShowing()) {
            emojiBoard.removeFromSuperview()
            self.frame = CGRectMake(self.frame.origin.x, self.originY,self.frame.width, baseHeight)
            self.selectEmojiBtn.selected = false
            showKeyBoard()
        }
        else {
            self.myInputView.resignFirstResponder()
            self.emojiBoard.removeFromSuperview()
            self.addSubview(emojiBoard)
            self.selectEmojiBtn.selected = true

            self.frame = CGRectMake(self.frame.origin.x, self.originY-emojiBoard.frame.height,
                                    self.frame.width, baseHeight+emojiBoard.frame.height)

            self.delegate.keyBoardOpenClose?(true, keyBoardHeight: emojiBoard.frame.height)
        }
    }

    func sendBtnClicked() {
        if(myInputView.text != nil && (myInputView.text!).characters.count>0 && delegate != nil) {

            //self.selectEmojiBtn.selected = false
            //self.emojiBoard.removeFromSuperview()
            //self.frame = CGRectMake(self.frame.origin.x, self.originY, self.frame.width, baseHeight)
            //myInputView.resignFirstResponder()

            if (CachedData.isUserLogined()) {
                delegate.sendText(myInputView.text!)
            }
            else {
                //用户未登录
                delegate.disableUserSendMessage?()
            }
            myInputView.text = ""
        }
    }

    func emojiSendBtnClicked() {
        sendBtnClicked()
        //self.selectEmojiBtn.selected = false
        selectEmojiClicked()
    }


    func imgPicked(img: [UIImage]) {
        if(delegate != nil) {
            delegate.sendImg!(img[0])
        }
    }

    func closeKeyBoard() {
        myInputView.resignFirstResponder()
        emojiBoard.removeFromSuperview()
        self.selectEmojiBtn.selected = false
        self.frame = CGRectMake(self.frame.origin.x, self.originY,self.frame.width, baseHeight)
    }

    private func setMoveViewsWithKeyBoardEnabled() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardOpend:",
                                                        name:UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardClosed:",
                                                        name: UIKeyboardWillHideNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:",
                                                        name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    func keyboardWillChangeFrame(notifiycation:NSNotification) {
        let info = notifiycation.userInfo!
        let boradHeight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height
        LogUtils.log("keyboardWillChangeFrame():boradHeight=\(boradHeight), isKeyBoardShowing=\(isKeyBoardShowing)")

        emojiBoard.removeFromSuperview()
        self.frame = CGRectMake(self.frame.origin.x, self.originY-boradHeight, self.frame.width, baseHeight+boradHeight)
    }

    func keyboardOpend(notifiycation:NSNotification) {

        let info = notifiycation.userInfo!
        let boradHeight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height
        LogUtils.log("keyboardOpend():boradHeight=\(boradHeight)")

        self.isKeyBoardShowing = true

        self.selectEmojiBtn.selected = false

        self.delegate.keyBoardOpenClose?(true, keyBoardHeight: boradHeight)
    }

    func keyboardClosed(notifiycation:NSNotification) {

        let info = notifiycation.userInfo!
        let boradHeight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height
        LogUtils.log("keyboardClosed():boradHeight=\(boradHeight)")

        self.isKeyBoardShowing = false

        emojiBoard.removeFromSuperview()
        self.frame = CGRectMake(self.frame.origin.x, self.originY, self.frame.width, baseHeight)

        self.selectEmojiBtn.selected = false

        self.delegate.keyBoardOpenClose?(false, keyBoardHeight: boradHeight)
    }

    func isEmojiShowing() -> Bool {
        let subs = self.subviews
        for sub in subs {
            if(sub is EmojiKeyBoardView) {
                return true
            }
        }
        return false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:UITextViewDelegate代理
    func textViewDidChange(textView: UITextView) {
        var textStr:NSString = NSString(string:textView.text)
        let range = textStr.rangeOfString("\n")
        if(range.length>0)
        {
            //过滤掉回车
            textStr = textStr.substringWithRange(NSMakeRange(0, textStr.length-range.length))
            textView.text = textStr as String
            self.sendBtnClicked()
        }
        
    }
}
