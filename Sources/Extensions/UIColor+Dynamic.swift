//
//  UIColor+Dynamic.swift
//  MdEditor
//
//  Created by Vlad on 15.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

extension UIColor {
	static func color(light: UIColor, dark: UIColor, highContrastLight: UIColor, highContrastDark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				let isDarkMode = traitCollection.userInterfaceStyle == .dark
				let isHighContrast = traitCollection.accessibilityContrast == .high
				
				switch (isDarkMode, isHighContrast) {
				case (true, false):
					return dark
				case (true, true):
					return highContrastDark
				case (false, false):
					return light
				case (false, true):
					return highContrastLight
				}
			}
		} else {
			return light
		}
	}
	
	static func color(light: UIColor, dark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				return traitCollection.userInterfaceStyle == .dark ? dark : light
			}
		} else {
			return light
		}
	}
}
