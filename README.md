# @tap-payments/apple-pay-rn

ReactNative wrapper for apple pay button

## Installation

```sh
npm install @tap-payments/apple-pay-rn

cd ios && pod install
```

### Configure SDK Example


```ts
enum SdkMode {
  production,
  sandbox,
}
```

```ts
enum AllowedCardNetworks {
  VISA = 'VISA',
  AMEX = 'AMEX',
  JCB = 'JCB',
  MADA = 'MADA',
}

enum MerchantCapabilities {
  threeDSecure,
  credit,
  debit,
}
```

```ts
ApplePayConfig = {
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
```
## Usage

```ts 
const init = useCallback(async () => {
    try {
            const config = {
            sandboxKey: 'pk_test_xxxxxxxxxxxxxxxxxxx',    // public key
            productionKey: 'pk_test_xxxxxxxxxxxxxxxxxxx', // public key
            countryCode: 'US',
            transactionCurrency: TapCurrencyCode.USD,
            allowedCardNetworks: [AllowedCardNetworks.VISA],
            environmentMode: SdkMode.sandbox,
            merchantId: 'xxxxxxx',
            amount: 23,
            merchantCapabilities: [
              MerchantCapabilities.threeDSecure,
              MerchantCapabilities.credit,
              MerchantCapabilities.debit,
            ],
        };
        

      let res: AppleToken = await getApplePayToken(config);
      // let res: TapToken = await getTapToken(config);

      console.log("🚀", JSON.stringify(res))
    } catch (error) {
      console.log("🚀", JSON.stringify(error))
    }
  }, []);
```

```ts
    enum ApplePayButtonType {
        appleLogoOnly,
        buyWithApplePa,
        setupApplePay,
        payWithApplePa,
        donateWithApplePay,
        checkoutWithApplePay,
        bookWithApplePay,
        subscribeWithApplePay,
    }

    enum ApplePayButtonStyle {
        Black,
        White,
        WhiteOutline,
        Auto,
    }

    <ApplePay
        style={styles.button}
        onPress={init}
        buttonStyle={ApplePayButtonStyle.Black}
        buttonType={ApplePayButtonType.appleLogoOnly}
    />
```
