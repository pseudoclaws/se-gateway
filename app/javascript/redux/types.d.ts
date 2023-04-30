export interface CurrentUserProps {
  isLoading: boolean;
  isSignedIn: boolean;
  attributes: {
    firstName: string;
  };
}

export interface GatewayState {
  reduxTokenAuth: {
    currentUser: CurrentUserProps;
  };
  connections: any[];
  accounts: any[];
  transactions: any[];
  alerts: any[];
}
