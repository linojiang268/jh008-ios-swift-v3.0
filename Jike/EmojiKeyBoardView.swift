//
//  EmojiKeyBoardView.swift
//  Jike
//
//  Created by Iosmac on 15/6/20.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


protocol EmojiKeyBoardViewDelegate {

    func emojiSendBtnClicked()
}

//Emoji的封装view
class EmojiKeyBoardView: UIView, ISEmojiViewDelegate {

    var inputViewOutSide:UITextField!
    var sendEmojiBtn:UIButton!
    let padding = UISettings.common_table_padding

    var delegate:EmojiKeyBoardViewDelegate!

    init(x:CGFloat, y:CGFloat) {
        super.init(frame: CGRectMake(x, y, UiUtils.getBaseWidth(), UISettings.emoji_panel_view_height))

        let emojiV = ISEmojiView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height-40))
        emojiV.delegate = self
        self.addSubview(emojiV)
        self.backgroundColor = Color.common_page_bg_color

        self.sendEmojiBtn = UIButton(frame: CGRectMake(0, self.frame.height-40, self.frame.width, 40))
        self.sendEmojiBtn.backgroundColor = Color.styleColor
        self.sendEmojiBtn.setTitle("发    送", forState: UIControlState.Normal)
        self.sendEmojiBtn.setTitleColor(Color.white, forState: UIControlState.Normal)
        self.sendEmojiBtn.titleLabel?.font = UISettings.getFontBold(UISettings.title_view_title_text_size)
        self.sendEmojiBtn.addTarget(self, action: "emojiSendBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)

        self.addSubview(self.sendEmojiBtn)
    }

    func emojiView(emojiView: ISEmojiView!, didSelectEmoji emoji: String!) {
        if(inputViewOutSide != nil) {
            inputViewOutSide.text = inputViewOutSide.text! + emoji
        }
    }

    func emojiView(emojiView: ISEmojiView!, didPressDeleteButton deletebutton: UIButton!) {
        if(self.inputViewOutSide != nil && self.inputViewOutSide.text != nil && self.inputViewOutSide.text?.characters.count>0) {
            let text = self.inputViewOutSide.text!
            let index = text.endIndex.advancedBy(-1)
            if(index >= text.startIndex) {
                self.inputViewOutSide.text = inputViewOutSide.text?.substringToIndex(index)
            }
            if(self.inputViewOutSide.text?.characters.count<=0)
            {
               //inputViewOutSide.hiddenPlaceHolder(false)
            }
        }
        
    }

    func emojiSendBtnClicked() {
        if(delegate != nil) {
            delegate.emojiSendBtnClicked()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}