//
//  AdaptiveButtonsStateManager.swift
//  AdaptiveTabBarControllerSample
//
//  Created by Arcilite on 18.09.14.
//  Copyright (c) 2014 Ramotion. All rights reserved.
//

import UIKit

public let countDaysToSmallTextState = 14
public let countDaysToImageState = 30

public let defaultInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
public let defaultSmallTitleModeFont = UIFont(name: "Helvetica", size: 10.0)!
public let defaultSmallTitleModeImageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
public let defaultImageModeInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
public let defaultSmallTitleModeOffset = UIOffset.init(horizontal: 0, vertical: 20)
public let defaultOffset = UIOffset.init(horizontal: 0, vertical: 00)
public let tabColor = UIColor(red: 169 / 255, green: 79 / 255, blue: 152 / 255, alpha: 1.0)

@objc public protocol AdaptiveApperanceProtocol {
    @objc optional func setFontToAdaptiveButton(font: UIFont)
    @objc optional func setTitleToAdaptiveButton(text: String)
    @objc optional func setImageToAdaptiveButton(image: UIImage?)
    @objc optional func setHighlightedToAdaptiveButton(image: UIImage?)
    @objc optional func setBackgroundImageToAdaptiveButton(image: UIImage?)
    @objc optional func setSelectedImageToAdaptiveButton(image: UIImage?)
    @objc optional func setImageInsetsToAdaptiveButton(insets: UIEdgeInsets)
    @objc optional func setTitleOffsetToAdaptiveButton(offset: UIOffset)
    @objc optional func setTitleColorToAdaptiveButton(titleColor: UIColor)
}

public let selected = "Selected"
public let highlighted = "Higlihted"

public class AdaptiveButtonsStateManager {

    public convenience init(state: AdaptiveState, buttonsAray: [AdaptiveApperanceProtocol], buttonsAppearance: [AdaptiveButtonAppearance]) {
        self.init()
        AdaptiveButtonsStateManager.configureButtonsState(state: state, buttonsAray: buttonsAray, buttonsAppearance: buttonsAppearance)
    }

    public static func configureButtonsState(state: AdaptiveState, buttonsAray: [AdaptiveApperanceProtocol], buttonsAppearance: [AdaptiveButtonAppearance]) {

        let state: String = state.currentItemState

        let countElements = min(buttonsAray.count, buttonsAppearance.count)
        for index in 0..<countElements {

            let button: AdaptiveApperanceProtocol = buttonsAray[index]
            let buttonApperance = buttonsAppearance[index]

            if let title = buttonApperance.getButonTitleForState(state: state) {
                button.setTitleToAdaptiveButton?(text: title)
            }

            if let image = buttonApperance.getButonImageForState(state: state) {
                button.setImageToAdaptiveButton?(image: image)
            }

            if let selectedImage = buttonApperance.getButonImageForState(state: state + selected) {
                button.setSelectedImageToAdaptiveButton?(image: selectedImage)
            }

            if let highlightedImage = buttonApperance.getButonImageForState(state: state + highlighted) {
                button.setHighlightedToAdaptiveButton?(image: highlightedImage)
            }

            if let backgroundImage = buttonApperance.getButonImageForState(state: state) {
                button.setBackgroundImageToAdaptiveButton?(image: backgroundImage)
            }

            if let titleColor = buttonApperance.getTitleColorForState(state: state) {
                button.setTitleColorToAdaptiveButton?(titleColor: titleColor)
            }
            
            let font = buttonApperance.getButonTitleFontForState(state: state)
            button.setFontToAdaptiveButton?(font: font)
            
            let imageInset = buttonApperance.getImageInsetsForState(state: state)
            button.setImageInsetsToAdaptiveButton?(insets: imageInset)

            let titleOffset = buttonApperance.getTitleOffsetForState(state: state)
            button.setTitleOffsetToAdaptiveButton?(offset: titleOffset)
        }
    }
}
