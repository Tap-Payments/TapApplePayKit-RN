//
//  ApplePayRnView.swift
//  tap-payments-apple-pay-rn
//
//  Created by MahmoudShaabanAllam on 25/02/2023.
//

import TapApplePayKit_iOS

@objc(ApplePayRnViewManager)
class ApplePayRnViewManager: RCTViewManager {

  override func view() -> (ApplePayView) {
    let view = ApplePayView()
    return view
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}


class ApplePayView : UIView {
  
  
  let appleButton = TapApplePayButton()
  
  
  @objc var buttonType: String = "" {
    didSet { applyButtonConfiguration() }
  }
  @objc var buttonStyle: String = "" {
    didSet { applyButtonConfiguration() }
  }
  @objc var cornerRadius: CGFloat = 0.0 {
    didSet {
      appleButton.cornerRadius = cornerRadius
      applyButtonConfiguration()
    }
  }

  override init(frame: CGRect){
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView(){
    self.addSubview(appleButton)
  }

  private func applyButtonConfiguration() {
    appleButton.cornerRadius = cornerRadius
    appleButton.setup(
      buttonType: TapApplePayButtonType(rawValue: buttonType) ?? .PayWithApplePay,
      buttonStyle: TapApplePayButtonStyleOutline(rawValue: buttonStyle) ?? .Black
    )
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    appleButton.frame = bounds
  }

  override func reactSetFrame(_ frame: CGRect) {
    appleButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    applyButtonConfiguration()
    super.reactSetFrame(frame)
  }
}

