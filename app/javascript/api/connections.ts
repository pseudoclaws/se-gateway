import axios from "axios";
import { requestHeaders } from "./index";

const list = async () => {
  const response = await axios.get("/api/v1/connections", {
    headers: requestHeaders(),
  });
  const { connections } = response.data;
  return { connections };
};

const listAccounts = async (connectionId: string) => {
  const response = await axios.get(`/api/v1/connections/${connectionId}`, {
    headers: requestHeaders(),
  });
  const { accounts } = response.data;
  return { accounts };
};

const createSession = async () => {
  const response = await axios.post(
    "/api/v1/connection_sessions",
    {},
    {
      headers: requestHeaders(),
    }
  );
  const { connect_session } = response.data;
  return { redirectUrl: connect_session.data.attributes.connect_url };
};

const refresh = async (connectionId: string, reconnect: boolean) => {
  const response = await axios.put(
    `/api/v1/connections/${connectionId}`,
    {
      reconnect,
    },
    {
      headers: requestHeaders(),
    }
  );
  const { connection } = response.data;
  return { connection };
};

const destroy = async (connectionId: string) => {
  await axios.delete(`/api/v1/connections/${connectionId}`, {
    headers: requestHeaders(),
  });
  return connectionId;
};

export const connectionApi = {
  list,
  listAccounts,
  createSession,
  refresh,
  destroy,
};
