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
      self.tapApplePay.createTapToken(for: token, onTokenReady: { tapToken in
        resolve(tapToken.dictionary)
      }, onErrorOccured: { (session, result, error) in
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

private enum CodingKeys: String, CodingKey {
    
  case identifier         = "id"
  case object             = "object"
  case card               = "card"
  case type               = "type"
  case creationDate       = "creationDate"
  case clientIPAddress    = "clientIPAddress"
  case isLiveMode         = "isLiveMode"
  case isUsed             = "isUsed"
  case lastFourDigits     = "lastFour"
  case expirationMonth    = "expMonth"
  case expirationYear     = "expYear"
  case binNumber          = "firstSix"
  case brand              = "brand"
  case funding            = "funding"
  case cardholderName     = "name"
  case customerIdentifier = "customer"
  case fingerprint        = "fingerprint"
  case address            = "address"
}


extension TokenizedCard: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(identifier, forKey: .identifier)
    try container.encode(object, forKey: .object)
    try container.encode(lastFourDigits, forKey: .lastFourDigits)
    try container.encode(expirationMonth, forKey: .expirationMonth)
    try container.encode(expirationYear, forKey: .expirationYear)
    try container.encode(binNumber, forKey: .binNumber)
    try container.encode(brand, forKey: .brand)
    try container.encode(funding, forKey: .funding)
    try container.encode(cardholderName, forKey: .cardholderName)
    try container.encode(customerIdentifier, forKey: .customerIdentifier)
    try container.encode(fingerprint, forKey: .fingerprint)
    try container.encode(address, forKey: .address)
  }
}

extension TokenType: Encodable {
  
}


extension Token: Encodable {
  
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(identifier, forKey: .identifier)
    try container.encode(object, forKey: .object)
    try container.encode(card, forKey: .card)
    try container.encode(type, forKey: .type)
    try container.encode(creationDate, forKey: .creationDate)
    try container.encode(clientIPAddress, forKey: .clientIPAddress)
    try container.encode(isLiveMode, forKey: .isLiveMode)
    try container.encode(isUsed, forKey: .isUsed)
  }
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
