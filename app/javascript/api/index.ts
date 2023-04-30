export const requestHeaders = () => ({
  "access-token": window.localStorage.getItem("access-token"),
  "token-type": "Bearer",
  client: window.localStorage.getItem("client"),
  uid: window.localStorage.getItem("uid"),
});

export * from "./connections";
export * from "./accounts";
