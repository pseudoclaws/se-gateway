import { connectionApi } from "../api";
import store from "../redux/store";
import { setConnections } from "../redux/actions/connections";

export async function connectionsLoader() {
  try {
    const { connections } = await connectionApi.list();
    store.dispatch(setConnections(connections));
    return { connections };
  } catch (e) {
    console.log(e);
    return null;
  }
}
