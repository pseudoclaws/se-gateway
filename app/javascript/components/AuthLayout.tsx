import React from "react";
import { useLoaderData, useOutlet } from "react-router-dom";
import { AuthProvider } from "../hooks/useAuth";
import store from "../redux/store";
import { Provider } from "react-redux";

export const AuthLayout = () => {
  const outlet = useOutlet();

  return (
    <Provider store={store}>
      <AuthProvider>{outlet}</AuthProvider>
    </Provider>
  );
};
