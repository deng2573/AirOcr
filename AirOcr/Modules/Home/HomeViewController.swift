//
//  HomeViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {

  private lazy var takePictureButton: UIButton = {
    let button = UIButton(type: .custom)
//    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
//    button.layer.cornerRadius = screenWidth * 0.4 / 2
    button.setImage(#imageLiteral(resourceName: "home_camera"), for: .normal)
    button.tap(action: { _ in
      self.takePicture()
    })
    return button
  }()
  
  private lazy var takePictureLabel: UILabel = {
    let label = UILabel()
    label.text = "拍照识别"
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.clipsToBounds = true
//    label.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    label.textAlignment = .center
    label.layer.cornerRadius = 5
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private lazy var imagePickerButton: UIButton = {
    let button = UIButton(type: .custom)
//    button.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
//    button.layer.cornerRadius = screenWidth * 0.4 / 2
    button.setImage(#imageLiteral(resourceName: "home_album"), for: .normal)
    button.tap(action: { _ in
      self.imagePicker()
    })
    return button
  }()
  
  private lazy var imagePickerLabel: UILabel = {
    let label = UILabel()
    label.text = "照片识别"
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.clipsToBounds = true
//    label.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    label.layer.cornerRadius = 5
    label.textAlignment = .center
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHomeView()
  }
  
  private func setupHomeView() {
    title = "识图"
    view.addSubview(takePictureLabel)
    takePictureLabel.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.snp.centerY).offset(-60)
      make.size.equalTo(CGSize(width: 100, height: 25))
    })
    
    view.addSubview(takePictureButton)
    takePictureButton.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(takePictureLabel.snp.top).offset(30)
      make.size.equalTo(CGSize(width: screenWidth * 0.4, height: screenWidth * 0.4))
    })
    
    view.addSubview(imagePickerButton)
    imagePickerButton.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.snp.centerY)
      make.size.equalTo(takePictureButton)
    })
    
    view.addSubview(imagePickerLabel)
    imagePickerLabel.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(imagePickerButton.snp.bottom).offset(-30)
      make.size.equalTo(takePictureLabel)
    })
  }
  
  private func takePicture() {
    let pickerVC = AipGeneralVC.viewController { image in
      if let image = image {
        self.detectText(image: image)
      }
    }
    self.present(pickerVC!, animated: true, completion: nil)
  }
  
  private func imagePicker() {
    let imagePickerViewController = TZImagePickerController(maxImagesCount: 1, columnNumber: 10, delegate: nil, pushPhotoPickerVc: true)
    imagePickerViewController?.allowTakePicture = true
    imagePickerViewController?.sortAscendingByModificationDate = true
    imagePickerViewController?.allowPickingGif = false
    imagePickerViewController?.allowPickingImage = true
    imagePickerViewController?.allowPickingOriginalPhoto = true
    imagePickerViewController?.allowPickingMultipleVideo = false
    imagePickerViewController?.allowPickingVideo = false
    imagePickerViewController?.showSelectBtn = false
    imagePickerViewController?.autoDismiss = false
    imagePickerViewController?.didFinishPickingPhotosHandle = { (photos, assets, isSelectOriginalPhoto) in
      if let image = photos?.first {
        self.detectText(image: image)
      }
    }
    imagePickerViewController?.imagePickerControllerDidCancelHandle = {
      self.dismiss(animated: false, completion: nil)
    }
    present(imagePickerViewController!, animated: true, completion: nil)
  }
  
  private func detectText(image: UIImage) {
    HUD.loading()
    OcrManager.detectText(image: image, completion: { info in
      DispatchQueue.main.async(execute: {
        HistoryManager.writeHistoryInfo(historyInfo: info)
        HUD.hide()
        self.dismiss(animated: false, completion: nil)
        let resultVC = OrcResultViewController(content: info)
        self.navigationController?.pushViewController(resultVC, animated: false)
      })
    })
  }
}
