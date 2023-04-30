import { accountApi } from "../api";
import store from "../redux/store";
import { setTransactions } from "../redux/actions/transactions";

export async function transactionsLoader({ params }) {
  try {
    const { transactions } = await accountApi.listTransactions(
      params.connectionId,
      params.accountId
    );
    store.dispatch(setTransactions(transactions));
    return { accountId: params.accountId };
  } catch (e) {
    console.log(e);
    return null;
  }
}
