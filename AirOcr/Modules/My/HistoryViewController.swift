//
//  HistoryViewController.swift
//  AirOcr
//
//  Created by Deng on 2019/8/14.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import SwipeCellKit

class HistoryViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = view.backgroundColor
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.allowsSelection = true
    tableView.allowsMultipleSelectionDuringEditing = true
    tableView.register(cellType: HistoryCell.self)
    return tableView
  }()
  
  private var historyList: [OcrResultInfo] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    requestHistory()
  }
  
  private func setUpView() {
    title = "历史记录"
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func requestHistory() {
    historyList = HistoryManager.readHistoryList()
    tableView.reloadData()
    showEmptyPrompt(show: historyList.isEmpty)
  }
}

extension HistoryViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return historyList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let info = historyList[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HistoryCell.self)
    cell.delegate = self
    cell.update(info: info)
    return cell
  }
}

extension HistoryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let history = historyList[indexPath.row]
    let resultVC = OrcResultViewController(content: history)
    self.navigationController?.pushViewController(resultVC, animated: false)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
}

extension HistoryViewController: SwipeTableViewCellDelegate {
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    let history = historyList[indexPath.row]
    if orientation == .right {
      let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
         self.historyList.remove(at: indexPath.row)
         HistoryManager.removeHistoryInfo(historyInfo: history)
      }
      delete.image = #imageLiteral(resourceName: "tab_home_selected")
      delete.backgroundColor = UIColor.themeBackgroundColor
      return [delete]
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
    var options = SwipeOptions()
    options.expansionStyle = .destructive
    options.transitionStyle = .border
    options.backgroundColor = .red
    options.minimumButtonWidth = 100
    return options
  }
  
}
