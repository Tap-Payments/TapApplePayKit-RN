import {
  AllowedCardNetworks,
  ApplePay,
  ApplePayButtonStyle,
  ApplePayButtonType,
  getApplePayToken,
  getTapToken,
  MerchantCapabilities,
  SdkMode,
  TapCurrencyCode,
  addApplePaySheetPresentedListener,
  setupApplePay,
  type AppleToken,
  type TapToken,
} from '@tap-payments/apple-pay-rn';
import * as React from 'react';
import { useCallback, useEffect } from 'react';
import { StyleSheet, View, Text, ScrollView, SafeAreaView } from 'react-native';

export default function App() {
  const [result, setResult] = React.useState<string | undefined>();

  useEffect(() => {
    const init = async () => {
      try {
        const res = await setupApplePay({
          sandboxKey: 'pk_test_xxxxxxxxx',
          productionKey: 'pk_live_xxxxxxxxx',
          merchantId: 'xxxxxxxxx',
          environmentMode: SdkMode.sandbox,
        });
        console.log('Apple Pay setup done, skipped:', res.alreadySetup);
        const res2 = await setupApplePay({
          sandboxKey: 'pk_test_xxxxxxxxx',
          productionKey: 'pk_live_xxxxxxx',
          merchantId: 'xxxxxxxxx',
          environmentMode: SdkMode.sandbox,
        });
        console.log('Apple Pay setup done, skipped:', res2.alreadySetup);
      } catch (err) {
        console.warn('Apple Pay setup failed:', err);
      }
    };

    init();
  }, []);

  useEffect(() => {
    const subscription = addApplePaySheetPresentedListener((event) => {
      console.log('Apple Pay sheet presented:', event.presented);
    });
    return () => subscription.remove();
  }, []);

  const tapToken = useCallback(async () => {
    try {
      const config = {
        sandboxKey: 'pk_test_xxxxxxxxx',
        productionKey: 'pk_live_xxxxxxx',
        countryCode: '',
        transactionCurrency: TapCurrencyCode.SAR,
        allowedCardNetworks: [AllowedCardNetworks.VISA],
        environmentMode: SdkMode.sandbox,
        merchantId: 'xxxxxxxxx',
        applePayMerchantId: 'merchant.xxxxxxxxx',
        amount: 23,
        merchantCapabilities: [
          MerchantCapabilities.threeDSecure,
          MerchantCapabilities.credit,
          MerchantCapabilities.debit,
        ],
      };
      let res: TapToken = await getTapToken(config);
      setResult(JSON.stringify(res));
    } catch (e) {
      setResult(e as string);
    }
  }, []);

  const applePayToken = useCallback(async () => {
    try {
      const config = {
        sandboxKey: '',
        productionKey: '',
        countryCode: 'US',
        transactionCurrency: TapCurrencyCode.USD,
        allowedCardNetworks: [AllowedCardNetworks.VISA],
        environmentMode: SdkMode.sandbox,
        merchantId: '',
        applePayMerchantId: '',
        amount: 23,
        merchantCapabilities: [
          MerchantCapabilities.threeDSecure,
          MerchantCapabilities.credit,
          MerchantCapabilities.debit,
        ],
      };
      let res: AppleToken = await getApplePayToken(config);
      setResult(res.stringAppleToken);
      setResult(JSON.stringify(res));
    } catch (e) {
      setResult(e as string);
    }
  }, []);
  return (
    <SafeAreaView style={styles.mainContainer}>
      <View style={styles.container}>
        <View style={styles.resultContainer}>
          <ScrollView>
            <Text>Result: {result}</Text>
          </ScrollView>
        </View>
        <Text>applePayToken</Text>
        <ApplePay
          style={styles.button}
          onPress={applePayToken}
          buttonStyle={ApplePayButtonStyle.Black}
          buttonType={ApplePayButtonType.appleLogoOnly}
        />
        <Text>tapToken</Text>
        <ApplePay
          style={styles.button}
          onPress={tapToken}
          buttonStyle={ApplePayButtonStyle.Black}
          buttonType={ApplePayButtonType.appleLogoOnly}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  resultContainer: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
  },
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  mainContainer: {
    flex: 1,
  },
  button: {
    alignSelf: 'stretch',
    height: 50,
    justifyContent: 'center',
    alignItems: 'center',
    margin: 10,
  },
});
