export type TapToken = {
  name?: string;
  currency?: string;
  isUsed: boolean;
  isLiveMode: boolean;
  created: number;
  brand: string;
  funding: string;
  expirationYear: number;
  id: string;
  expirationMonth: number;
  card: string;
  firstSix: string;
  fingerprint: string;
  clientIp?: string;
  object: string;
  lastFour: string;
};
