import { connectionApi } from "../api";

export async function newConnectionLoader() {
  try {
    const { redirectUrl } = await connectionApi.createSession();
    return { redirectUrl };
  } catch (e) {
    console.log(e);
    return null;
  }
}
