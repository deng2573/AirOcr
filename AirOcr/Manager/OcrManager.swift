//
//  OcrManager.swift
//  AirOcr
//
//  Created by Deng on 2019/8/14.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class OcrManager: NSObject {
  static func detectText(image: UIImage, completion: @escaping (OcrResultInfo) -> Void) {
    let options = ["language_type": "CHN_ENG", "detect_direction": "true"]
    AipOcrService.shard()?.detectText(from: image, withOptions: options, successHandler: { result in
      guard let  data = result, let json = JSON(data).rawString() else {
        HUD.show(text: "识别错误, 请稍后重试")
        return
      }
      
      let info = OcrResultInfo(json: json)
      
      let imageBase64 = image.pngData()!.base64EncodedString()
      var text = ""
      for word in info.words_result {
        text.append("\(word.words)\n")
      }
      
      info.text = text
      info.imageBase64 = imageBase64
      info.time = Date().timeIntervalSince1970
      completion(info)
    }, failHandler: { error in
    })
  }
  
}
