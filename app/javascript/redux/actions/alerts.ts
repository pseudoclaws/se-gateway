import { createAction } from "@reduxjs/toolkit";

export const addAlert = createAction<{
  message: string;
  severity: "success" | "warning" | "error";
  id: number;
}>("alerts/add");

export const removeAlert = createAction<number>("alerts/remove");

export const addError = (message: string) => addAlert({ message, severity: "error", id: (new Date).getTime() });
export const addSuccess = (message: string) => addAlert({ message, severity: "error", id: (new Date).getTime() });
