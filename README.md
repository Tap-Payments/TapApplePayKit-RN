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
## Setup (Prewarm)

Call `setupApplePay` once at app startup to pre-configure the Tap merchant. This avoids a network round-trip on the first payment request.

```ts
import { setupApplePay, SdkMode } from '@tap-payments/apple-pay-rn';

useEffect(() => {
  const init = async () => {
    try {
      const res = await setupApplePay({
        sandboxKey: 'pk_test_xxxxxxxxxxxxxxxxxxx',
        productionKey: 'pk_live_xxxxxxxxxxxxxxxxxxx',
        merchantId: 'xxxxxxx',
        environmentMode: SdkMode.sandbox,
      });
      console.log('Setup done, skipped:', res.alreadySetup);
    } catch (err) {
      console.warn('Setup failed:', err);
    }
  };
  init();
}, []);
```

```ts
ApplePaySetupConfig = {
  sandboxKey: string;
  productionKey: string;
  merchantId: string;
  environmentMode: SdkMode;
};
```

- Subsequent calls with the same credentials are no-ops and resolve immediately with `{ alreadySetup: true }`.
- If credentials change, call `setupApplePay` again with the new values.
- This step is optional. If you skip it, the setup network call happens automatically on the first token request (existing behavior).

## Events

### addApplePaySheetPresentedListener

Listen for when the Apple Pay sheet is presented or dismissed.

```ts
import { addApplePaySheetPresentedListener } from '@tap-payments/apple-pay-rn';

useEffect(() => {
  const subscription = addApplePaySheetPresentedListener((event) => {
    console.log('Apple Pay sheet presented:', event.presented);
  });
  return () => subscription.remove();
}, []);
```

- `event.presented` is `true` when the sheet appears and `false` when it is dismissed.
- Returns a subscription object. Call `.remove()` to unsubscribe (e.g. on component unmount).

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
