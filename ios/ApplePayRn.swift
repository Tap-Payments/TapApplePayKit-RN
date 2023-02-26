import TapApplePayKit_iOS
import PassKit
import CommonDataModelsKit_iOS

@objc(ApplePayRn)
class ApplePayRn: NSObject {
  
  let controller = RCTPresentedViewController()
  let tapApplePay: TapApplePay = .init()
  
  var argsDataSource:[String:Any]? = [:]
  
  
  public var sdkMode: SDKMode {
    if let sdkModeInt: Int = argsDataSource?["environmentMode"] as? Int {
      switch (sdkModeInt)  {
      case 0:
        return .production
      case 1:
        return .sandbox
      default:
        return .sandbox
      }
    }
    return .sandbox
  }
  
  public var sandboxKey: String? {
    if let secretKeyString: String = argsDataSource?["sandboxKey"] as? String {
      return secretKeyString
    }
    return nil
  }
  
  public var productionKey: String? {
    if let secretKeyString: String = argsDataSource?["productionKey"] as? String {
      return secretKeyString
    }
    return nil
  }
  
  public var transactionCurrency: TapCurrencyCode? {
    if let transactionCurrencyString: String = argsDataSource?["transactionCurrency"] as? String {
      return TapCurrencyCode(appleRawValue: transactionCurrencyString)
    }
    return nil
  }
  
  public var merchantID: String? {
    if let merchantIDString: String = argsDataSource?["merchantId"] as? String {
      return merchantIDString
    }
    return nil
  }
  
  
  public var amount: Double? {
    if let amountDouble: Double = argsDataSource?["amount"] as? Double {
      return amountDouble
    }
    return nil
  }
  
  
  public var countryCode: TapCountryCode? {
    if let countryCodeString: String = argsDataSource?["countryCode"] as? String {
      return TapCountryCode(rawValue: countryCodeString.uppercased())
    }
    return nil
  }
  
  public var paymentNetworks: [TapApplePayPaymentNetwork] {
    if let arrayString: [String]  = argsDataSource?["allowedCardNetworks"] as? [String] {
      var tapApplePayPaymentNetwork: [TapApplePayPaymentNetwork] = []
      arrayString.forEach {
        if let method = TapApplePayPaymentNetwork(rawValue: $0){
          tapApplePayPaymentNetwork.append(method)
        }
      }
      return tapApplePayPaymentNetwork
    }
    return []
  }
  
  public var  merchantCapability: PKMerchantCapability {
    var merchantCapabilityArray: PKMerchantCapability = []
    if let intArray: [Int]  = argsDataSource?["merchantCapabilities"] as? [Int] {
      intArray.forEach {
        switch($0) {
        case 0:
          merchantCapabilityArray.update(with: .capability3DS)
          break
        case 1:
          merchantCapabilityArray.update(with:.capabilityCredit)
          break
        case 2:
          merchantCapabilityArray.update(with:.capabilityDebit)
          break
        case 3:
          merchantCapabilityArray.update(with:.capabilityEMV)
          break
        default: break
        }
      }
    }
    return merchantCapabilityArray
  }
  
  
  
  @objc(generateApplePayRawToken:withResolver:withRejecter:)
  func generateApplePayRawToken(arguments: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
    guard let request = generateRequest(arguments: arguments) else {
      reject("Please Enter correct values", "Please Enter correct values", "wrong params")
      return
    }
   
    tapApplePay.authorizePayment(in: controller!, for: request) { token in
      resolve(["stringAppleToken": token.stringAppleToken])
    }
  }
  
  
  @objc(generateTapApplePayToken:withResolver:withRejecter:)
  func generateTapApplePayToken(arguments: NSDictionary,  resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
    guard let request = generateRequest(arguments: arguments) else {
      reject("Please Enter correct values", "Please Enter correct values", "wrong params")
      return
    }
   
    tapApplePay.authorizePayment(in: controller!, for: request) { token in
      print(token.stringAppleToken)
      self.tapApplePay.createTapToken(for: token, onTokenReady: { tapToken in
        print(tapToken)
      }, onErrorOccured: { (session, result, error) in
        print(error)
        reject("createTapTokenError", error.debugDescription, "createTapTokenError")
      })
    }
  }
  
  
  private func generateRequest(arguments: NSDictionary) -> TapApplePayRequest? {
    guard let arguments = arguments as? [String: Any] else {
      return nil
    }
    
    argsDataSource = arguments
    
    guard let productionKey = productionKey,
          let sandboxKey  = sandboxKey,
          let amount = amount,
          let merchantID = merchantID,
          let transactionCurrency = transactionCurrency,
          let countryCode = countryCode else {
      return nil
    }
    
    TapApplePay.sdkMode = sdkMode
    TapApplePay.secretKey = .init(sandbox: sandboxKey,
                                  production: productionKey)
    
    let myTapApplePayRequest:TapApplePayRequest = .init()
    myTapApplePayRequest.build(with: countryCode, paymentNetworks: paymentNetworks, paymentItems: [], paymentAmount: amount, currencyCode: transactionCurrency,merchantID:merchantID, merchantCapabilities: merchantCapability)
    return myTapApplePayRequest
  }
}
