export type TapToken = {
  card: {
    address: any;
    brand: string;
    customer: string;
    expMonth: number;
    expYear: number;
    fingerprint: string;
    firstSix: string;
    funding: string;
    id: string;
    lastFour: string;
    name: string;
    object: string;
  };
  clientIPAddress?: string;
  creationDate: number;
  id: string;
  isLiveMode: false;
  isUsed: false;
  object: string;
  type: number;
};
