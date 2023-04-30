import { createAction, createAsyncThunk } from "@reduxjs/toolkit";
import { connectionApi } from "../../../api";
import { addError } from "../alerts";

export const setConnections = createAction<any[]>("connections/set");
export const updateConnection = createAction<any>("connections/update");
export const deleteConnection = createAction<string>("connections/delete");

export const refreshConnection = createAsyncThunk(
  "connections/refresh",
  async (
    { connectionId, reconnect }: { connectionId: string; reconnect: boolean },
    { rejectWithValue, dispatch }
  ) => {
    try {
      const response = await connectionApi.refresh(connectionId, reconnect);
      return response.connection;
    } catch (e) {
      e.response.data.errors.forEach(error => dispatch(addError(error)));
      return rejectWithValue(e.response.data);
    }
  }
);

export const destroyConnection = createAsyncThunk(
  "connections/destroy",
  async (connectionId: string, { rejectWithValue, dispatch }) => {
    try {
      return connectionApi.destroy(connectionId);
    } catch (e) {
      e.response.data.errors.forEach(error => dispatch(addError(error)));
      return rejectWithValue(e.response.data);
    }
  }
);
