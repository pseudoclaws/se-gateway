import { createReducer } from "@reduxjs/toolkit";
import { addAlert, removeAlert } from "../actions/alerts";

export default createReducer([], (builder) => {
  builder.addCase(addAlert, (state, action) => [...state, action.payload]);
  builder.addCase(removeAlert, (state, action) => {
    const idx = state.findIndex((a) => a.id === action.payload);
    return idx < 0 ? state : [...state.slice(0, idx), ...state.slice(idx + 1)];
  });
});
