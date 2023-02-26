export enum AllowedCardNetworks {
  VISA = 'VISA',
  AMEX = 'AMEX',
  JCB = 'JCB',
  MADA = 'MADA',
}

export enum MerchantCapabilities {
  capability3DS,
  capabilityCredit,
  capabilityDebit,
  capabilityEMV,
}

export enum SdkMode {
  production,
  sandbox,
}

export enum SDKCallMode {
  getAppleToken,
  getTapToken,
}

export enum ApplePayButtonType {
  appleLogoOnly = 'plain',
  buyWithApplePay = 'buy',
  setupApplePay = 'setup',
  payWithApplePay = 'pay',
  donateWithApplePay = 'donate',
  checkoutWithApplePay = 'checkout',
  bookWithApplePay = 'book',
  subscribeWithApplePay = 'subscripe',
}

export enum ApplePayButtonStyle {
  Black = 'black',
  White = 'white',
  WhiteOutline = 'whiteoutline',
  Auto = 'auto',
}
