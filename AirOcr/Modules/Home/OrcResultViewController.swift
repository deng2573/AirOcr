//
//  OrcResultViewController.swift
//  AirOcr
//
//  Created by Deng on 2019/8/14.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class OrcResultViewController: ViewController {
  
  private lazy var textView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.backgroundColor = .white
    textView.clipsToBounds = true
    textView.layer.cornerRadius = 5
    textView.font = UIFont.boldSystemFont(ofSize: 16)
    textView.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    textView.textContainer.lineFragmentPadding = 0
    return textView
  }()

  private var content: OcrResultInfo
  
  init(content: OcrResultInfo) {
    self.content = content
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupData()
  }
  
  private func setupView() {
    title = "识别结果"
    view.addSubview(textView)
    textView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
    })
    
    let localFileButton = UIButton(type: .custom)
    localFileButton.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
    localFileButton.setTitle("复制", for: .normal)
    localFileButton.setTitleColor(.darkGray, for: .normal)
    localFileButton.layer.cornerRadius = 22
    localFileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    localFileButton.tap(action: { _ in
      UIPasteboard.general.string = self.textView.text
      HUD.show(text: "已复制到粘贴板")
    })
    let item = UIBarButtonItem(customView: localFileButton)
    navigationItem.rightBarButtonItem = item
  }
  
  private func setupData() {
    textView.text = content.text
  }
}
