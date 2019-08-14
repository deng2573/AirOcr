//
//  HistoryManager.swift
//  AirOcr
//
//  Created by Deng on 2019/8/14.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class HistoryManager: NSObject {
  static func readHistoryList() -> [OcrResultInfo] {
    var historyList: [OcrResultInfo] = []
    let historyStringList = UserDefaults.standard.stringArray(forKey: FilePath.History.history) ?? []
    for historyString in historyStringList {
      let history = OcrResultInfo(json: historyString)
      historyList.append(history)
    }
    return historyList
  }
  
  static func writeHistoryInfo(historyInfo: OcrResultInfo) {
    let standard = UserDefaults.standard
    let history = historyInfo.toJsonString()
    var historyList: [String] = []
    if let historys = standard.array(forKey: FilePath.History.history) {
      historyList = historys as! [String]
    }
    historyList.append(history)
    standard.set(historyList, forKey: FilePath.History.history)
  }
  
  static func removeHistoryInfo(historyInfo: OcrResultInfo) {
    let standard = UserDefaults.standard
    let item = historyInfo.toJsonString()
    if var historys = standard.array(forKey: FilePath.History.history) {
      for (index, history) in (historys as! [String]).enumerated() {
        if history == item {
          historys.remove(at: index)
        }
      }
      standard.set(historys, forKey: FilePath.History.history)
    }
  }
}
