const path = require('path');
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');
const pak = require('../package.json');

const root = path.resolve(__dirname, '..');
const modules = Object.keys({ ...pak.peerDependencies });
const escape = (s) => s.replace(/[|\\{}()[\]^$+*?.]/g, '\\$&');

/**
 * Metro configuration
 * https://reactnative.dev/docs/metro
 *
 * The library source lives one level up, so watch it and make sure its
 * peerDependencies (react, react-native) resolve from this app only.
 *
 * @type {import('@react-native/metro-config').MetroConfig}
 */
const config = {
  watchFolders: [root],
  resolver: {
    blockList: modules.map(
      (m) => new RegExp(`^${escape(path.join(root, 'node_modules', m))}\\/.*$`)
    ),
    extraNodeModules: modules.reduce((acc, name) => {
      acc[name] = path.join(__dirname, 'node_modules', name);
      return acc;
    }, {}),
    nodeModulesPaths: [path.join(__dirname, 'node_modules')],
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
