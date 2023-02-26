import type {
  AllowedCardNetworks,
  MerchantCapabilities,
  SdkMode,
  TapCurrencyCode,
} from './enums';

export type ApplePayConfig = {
  sandboxKey: string;
  productionKey: string;
  countryCode: string;
  transactionCurrency: TapCurrencyCode;
  allowedCardNetworks: AllowedCardNetworks[];
  environmentMode: SdkMode;
  merchantId: string;
  amount: number;
  merchantCapabilities: MerchantCapabilities[];
};
