//
//  OcrResultInfo.swift
//  AirOcr
//
//  Created by Deng on 2019/8/14.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class OcrResultInfo: EVObject {
  var direction = -1
  var log_id = 1
  var words_result: [OcrWordInfo] = []
  var words_result_num = 0
  
  var text = ""
  var imageBase64 = ""
  var time: TimeInterval = 0
}

class OcrWordInfo: EVObject {
  var location = OcrLocationInfo()
  var words = ""
}

class OcrLocationInfo: EVObject {
  var height = 0
  var left = 0
  var top = 0
  var width = 0
}
