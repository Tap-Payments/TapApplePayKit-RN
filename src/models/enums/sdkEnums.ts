export enum AllowedCardNetworks {
  AMEX = 'AMEX',
  CARTESBANCAIRES = ' CARTESBANCAIRES',
  DISCOVER = ' DISCOVER',
  EFTPOS = ' EFTPOS',
  ELECTRON = ' ELECTRON',
  IDCREDIT = ' IDCREDIT',
  INTERAC = ' INTERAC',
  JCB = ' JCB',
  MAESTRO = ' MAESTRO',
  MASTERCARD = ' MASTERCARD',
  PRIVATELABEL = ' PRIVATELABEL',
  QUICPAY = ' QUICPAY',
  SUICA = ' SUICA',
  VISA = ' VISA',
  VPAY = ' VPAY',
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

export enum AmountModificationType {
  Percentage,
  Fixed,
}

export enum TapPaymentType {
  All = 1,
  /// Meaning, only web (redirectional) payments wil be visible (like KNET, BENEFIT, FAWRY, etc.)
  Web = 2,
  /// Meaning, only card (debit and credit) form payment will be visible
  Card = 3,
  /// Meaning, only telecom operators payments wil be visible (like VIVA, STC, etc.)
  Telecom = 4,
  /// Meaning, only Apple pay will be visible
  ApplePay = 5,
  /// Only device payments. (e.g. Apple pay)
  Device = 6,
  /// If the user is paying with a saved card
  SavedCard = 7,
}

/// Defines the style of the checkout close button
export enum CheckoutCloseButtonEnum {
  /// Will show a close button icon only
  icon = 1,
  /// Will show the word "CLOSE" as a title only
  title = 2,
}

export enum TransactionMode {
  purchase,
  authorizeCapture,
  cardSaving,
  cardTokenization,
}

export enum AddressType {
  residential,
  commercial,
}
