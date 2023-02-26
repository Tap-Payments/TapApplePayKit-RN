import React from 'react';
import {
  NativeModules,
  Platform,
  requireNativeComponent,
  StyleSheet,
  TouchableOpacity,
  UIManager,
  View,
  ViewStyle,
} from 'react-native';
import type {
  ApplePayButtonStyle,
  ApplePayButtonType,
  ApplePayConfig,
  AppleToken,
  TapToken,
} from './models';

export * from './models';

const LINKING_ERROR =
  `The package '@tap-payments/apple-pay-rn' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type ApplePayButtonProps = {
  buttonType: ApplePayButtonType;
  buttonStyle: ApplePayButtonStyle;
  style: ViewStyle;
};

const ApplePayButton =
  UIManager.getViewManagerConfig('ApplePayRnView') != null
    ? requireNativeComponent<ApplePayButtonProps>('ApplePayRnView')
    : () => {
        throw new Error(LINKING_ERROR);
      };

const ApplePayRn = NativeModules.ApplePayRn
  ? NativeModules.ApplePayRn
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function getApplePayToken(config: ApplePayConfig) {
  return new Promise<AppleToken>(async (resolve, reject) => {
    try {
      if (Platform.OS === 'android') {
        reject('Not available for android');
      }
      const result = await ApplePayRn.generateApplePayRawToken({
        ...config,
      });
      const res = result as AppleToken;
      resolve(res);
    } catch (e) {
      let error = e as { message: string };
      if (error.message) {
        reject(error.message);
      }
    }
  });
}

export function getTapToken(config: ApplePayConfig) {
  return new Promise<TapToken>(async (resolve, reject) => {
    try {
      if (Platform.OS === 'android') {
        reject('Not available for android');
      }
      const result = await ApplePayRn.generateTapApplePayToken({
        ...config,
      });
      resolve(result as TapToken);
    } catch (e) {
      let error = e as { message: string };
      if (error.message) {
        reject(error.message);
      }
    }
  });
}

export function ApplePay({
  buttonType,
  buttonStyle,
  onPress,
  style,
}: {
  buttonType: ApplePayButtonType;
  buttonStyle: ApplePayButtonStyle;
  onPress: () => void;
  style: ViewStyle;
}) {
  if (Platform.OS === 'android') {
    return <View />;
  }

  return (
    <View style={[style]}>
      <ApplePayButton
        buttonStyle={buttonStyle}
        buttonType={buttonType}
        style={style}
      />
      <TouchableOpacity
        style={[styles.touchableOpacityStyle]}
        onPress={onPress}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  touchableOpacityStyle: {
    position: 'absolute',
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'transparent',
  },
});
