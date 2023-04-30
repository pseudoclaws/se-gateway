import { createReducer } from "@reduxjs/toolkit";
import {
  deleteConnection,
  destroyConnection,
  refreshConnection,
  setConnections,
  updateConnection,
} from "../actions/connections";

const update = (state, action) => {
  const idx = state.findIndex(
    (c) =>
      c.data.attributes.external_id ===
      action.payload.data.attributes.external_id
  );
  return idx > -1
    ? [...state.slice(0, idx), action.payload, ...state.slice(idx + 1)]
    : state;
};

const remove = (state, action) => {
  const idx = state.findIndex(
    (c) => c.data.attributes.external_id === action.payload
  );
  return idx > -1 ? [...state.slice(0, idx), ...state.slice(idx + 1)] : state;
};

export default createReducer([], (builder) => {
  builder.addCase(setConnections, (state, action) => action.payload);
  builder.addCase(updateConnection, update);
  builder.addCase(deleteConnection, remove);
  builder.addCase(refreshConnection.fulfilled, update);
  builder.addCase(destroyConnection.fulfilled, remove);
});
