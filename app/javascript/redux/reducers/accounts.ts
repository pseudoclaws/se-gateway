import { createReducer } from "@reduxjs/toolkit";
import { setAccounts } from "../actions/accounts";

export default createReducer([], (builder) => {
  builder.addCase(setAccounts, (state, action) => action.payload);
});
