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
  private var lastSize: CGSize = .zero

  
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

  // Re-apply the configuration whenever the size changes. Unlike reactSetFrame,
  // layoutSubviews is called on both the old architecture and the new
  // architecture's legacy view interop layer.
  override func layoutSubviews() {
    super.layoutSubviews()
    appleButton.frame = bounds
    if bounds.size != lastSize && bounds.width > 0 && bounds.height > 0 {
      lastSize = bounds.size
      applyButtonConfiguration()
    }
  }
}

