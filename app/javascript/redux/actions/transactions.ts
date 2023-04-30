import { createAction } from "@reduxjs/toolkit";

export const setTransactions = createAction<any[]>("transactions/set");
