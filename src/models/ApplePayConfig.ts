import type {
  AllowedCardNetworks,
  MerchantCapabilities,
  SdkMode,
  TapCurrencyCode,
} from './enums';

export type ApplePaySetupConfig = {
  sandboxKey: string;
  productionKey: string;
  merchantId: string;
  environmentMode: SdkMode;
};

export type ApplePayConfig = {
  sandboxKey: string;
  productionKey: string;
  countryCode: string;
  transactionCurrency: TapCurrencyCode;
  allowedCardNetworks: AllowedCardNetworks[];
  environmentMode: SdkMode;
  merchantId: string;
  amount: number;
  applePayMerchantId: string;
  merchantCapabilities: MerchantCapabilities[];
};
