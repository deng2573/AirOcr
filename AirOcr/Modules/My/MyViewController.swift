//
//  MyViewController.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    return tableView
  }()
  
  private var cellList = [[StaticTableViewCell]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    loadCellData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  func setUpView() {
    title = "我的"
    view.addSubview(tableView)
    tableView.backgroundColor = view.backgroundColor
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: MyHeaderTableViewCell.self)
    tableView.register(cellType: MyNormalTableViewCell.self)
  }
  
  func loadCellData() {
    cellList = [
      [
        StaticTableViewCell(cellType: MyHeaderTableViewCell.self, didSelectPushTo: UpdateUserInfoViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "历史记录", icon: UIImage(), didSelectPushTo: HistoryViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "意见反馈", icon: UIImage(), didSelectPushTo: FeedbackViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "关于我们", icon: UIImage(), didSelectPushTo: AboutAppViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "设置", icon: UIImage(), didSelectPushTo: MySettingViewController()),
      ]
    ]
    tableView.reloadData()
  }
  
}

extension MyViewController:  UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return cellList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellList[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = self.cellList[indexPath.section][indexPath.row]
    
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: item.cellType)
    
    if let cell  = cell as? MyHeaderTableViewCell {
      cell.update()
    }
    
    if let cell  = cell as? MyNormalTableViewCell {
      cell.update(title: item.title)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let item = self.cellList[indexPath.section][indexPath.row]
    if item.cellType == MyHeaderTableViewCell.self {
      return 120
    }
    return 60
  }
  
}

extension MyViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.cellList[indexPath.section][indexPath.row]
    navigationController?.pushViewController(item.didSelectPushTo, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 0.1
    }
    return 16
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
}
