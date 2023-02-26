import {
  AllowedCardNetworks,
  ApplePay,
  ApplePayButtonStyle,
  ApplePayButtonType,
  AppleToken,
  getApplePayToken,
  MerchantCapabilities,
  SdkMode,
  TapCurrencyCode,
} from '@tap-payments/apple-pay-rn';
import * as React from 'react';
import { useCallback } from 'react';
import { StyleSheet, View, Text, ScrollView, SafeAreaView } from 'react-native';

export default function App() {
  const [result, setResult] = React.useState<string | undefined>();

  const init = useCallback(async () => {
    try {
      const config = {
        sandboxKey: 'sk_test_cvSHaplrPNkJO7dhoUxDYjqA',
        productionKey: 'sk_live_QglH8V7Fw6NPAom4qRcynDK2',
        countryCode: 'US',
        transactionCurrency: TapCurrencyCode.USD,
        allowedCardNetworks: [AllowedCardNetworks.VISA],
        environmentMode: SdkMode.sandbox,
        merchantId: 'merchant.tap.gosell',
        amount: 23,
        merchantCapabilities: [
          MerchantCapabilities.capability3DS,
          MerchantCapabilities.capabilityCredit,
          MerchantCapabilities.capabilityDebit,
          MerchantCapabilities.capabilityEMV,
        ],
      };
      // await getApplePayToken(config);

      let res: AppleToken = await getApplePayToken(config);
      setResult(res.stringAppleToken);
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
        <ApplePay
          style={styles.button}
          onPress={init}
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
  },
});
