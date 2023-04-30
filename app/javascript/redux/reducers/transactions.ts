import { createReducer } from "@reduxjs/toolkit";
import { setTransactions } from "../actions/transactions";

export default createReducer([], (builder) => {
  builder.addCase(setTransactions, (state, action) => action.payload);
});
