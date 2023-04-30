export async function signInLoader({ request }) {
  const url = new URL(request.url);
  const needsConfirmation = url.searchParams.get("account_confirmation_needed");
  const confirmationSuccess = url.searchParams.get("account_confirmation_success");
  return { needsConfirmation, confirmationSuccess }
}
