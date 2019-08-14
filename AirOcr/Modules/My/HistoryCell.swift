//
//  FileInformationCell.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import SwipeCellKit
import YBImageBrowser

class HistoryCell: SwipeTableViewCell {

  private lazy var contentBackgroundView: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = .white
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.borderColor = view.layer.shadowColor
    view.layer.borderWidth = 0.01
    view.layer.cornerRadius = 5
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = .zero
    return view
  }()
  
  lazy var coverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 5
    return imageView
  }()
  
  private lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.numberOfLines = 1
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private lazy var timeLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private var coverImage: UIImage?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = UIColor.themeBackgroundColor
    setupView()
  }
  
  private func setupView() {
    contentView.addSubview(contentBackgroundView)
    contentBackgroundView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
    })
    
    contentView.addSubview(coverImageView)
    coverImageView.snp.makeConstraints({ (make) in
      make.centerY.equalToSuperview()
      make.left.equalTo(32)
      make.size.equalTo(CGSize(width: 80, height: 80))
    })
    coverImageView.addTapGestureTarget(self, action: #selector(showImage))
    
    contentView.addSubview(contentLabel)
    contentLabel.snp.makeConstraints({ (make) in
      make.left.equalTo(coverImageView.snp.right).offset(20)
      make.right.equalTo(-32)
      make.top.equalTo(coverImageView).offset(5)
    })
    
    contentView.addSubview(timeLable)
    timeLable.snp.makeConstraints({ (make) in
      make.left.equalTo(contentLabel)
      make.bottom.equalTo(coverImageView.snp.bottom).offset(-5)
    })
  }
  
  @objc func showImage() {
    let data = YBImageBrowseCellData()
    data.imageBlock = {
      return self.coverImage
    }
    data.sourceObject = coverImageView
    let browser = YBImageBrowser()
    browser.dataSourceArray = [data]
    browser.currentIndex = 0
    browser.show()
  }
  
  func update(info: OcrResultInfo) {
    if !info.imageBase64.isEmpty, let avatarData = Data(base64Encoded: info.imageBase64) {
      coverImageView.image = UIImage(data: avatarData)
      coverImage = coverImageView.image
    }
    contentLabel.text = info.text
    timeLable.text = info.time.timeString()
  }

}
