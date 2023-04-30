import { connectionApi } from "../api";
import store from "../redux/store";
import { setAccounts } from "../redux/actions/accounts";

export async function accountsLoader({ params }) {
  try {
    const { accounts } = await connectionApi.listAccounts(params.connectionId);
    store.dispatch(setAccounts(accounts));
    return { connectionId: params.connectionId };
  } catch (e) {
    console.log(e);
    return null;
  }
}
