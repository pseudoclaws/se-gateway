import axios from "axios";
import { requestHeaders } from "./index";

const listTransactions = async (connectionId: string, accountId: string) => {
  const response = await axios.get(
    `/api/v1/connections/${connectionId}/accounts/${accountId}`,
    {
      headers: requestHeaders(),
    }
  );
  const { transactions } = response.data;
  return { transactions };
}

export const accountApi = {
  listTransactions,
}
