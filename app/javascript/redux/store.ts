import { configureStore } from "@reduxjs/toolkit";

import rootReducer from "./reducers";
import { GatewayState } from "./types";

import logger from 'redux-logger'

const store = configureStore<GatewayState>({
  reducer: rootReducer,
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(logger),
});

// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch;

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;

export default store;
