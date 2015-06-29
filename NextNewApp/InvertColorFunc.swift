//
//  InvertColorFunc.swift
//  NextNewApp
//
//  Created by Пользователь on 17.06.15.
//  Copyright (c) 2015 mpei. All rights reserved.
//

import UIKit

func InvertColor (color:UIColor) -> UIColor {
    var hue:CGFloat = 0.0
    var sat:CGFloat = 0.0
    var brt:CGFloat = 0.0
    var alf:CGFloat = 0.0
    color.getHue(&hue, saturation: &sat, brightness: &brt, alpha: &alf)
    return UIColor(hue: abs(1-hue), saturation: sat, brightness: abs(1-brt), alpha: alf)
}