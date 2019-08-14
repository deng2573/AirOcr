//
//  Const.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation
import UIKit

@_exported import Alamofire
@_exported import SwiftyJSON
@_exported import EVReflection
@_exported import UITableView_FDTemplateLayoutCell
@_exported import Photos
@_exported import TZImagePickerController
@_exported import IQKeyboardManagerSwift

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let statusBarHeight = UIApplication.shared.statusBarFrame.height
let navigationHeight = statusBarHeight + CGFloat(44)
let isComprehensiveScreen = navigationHeight == 88

