import { combineReducers } from "redux";
import { reduxTokenAuthReducer } from 'redux-token-auth'
import { GatewayState } from "../types";
import connections from "./connections";
import accounts from "./accounts";
import transactions from "./transactions";
import alerts from "./alerts";

const rootReducer = combineReducers<GatewayState>({
  alerts,
  reduxTokenAuth: reduxTokenAuthReducer,
  connections,
  accounts,
  transactions,
});

export default rootReducer;
