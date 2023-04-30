import * as React from "react";
import {
  createBrowserRouter,
  createRoutesFromElements,
  Route,
} from "react-router-dom";
import App from "../components/App";
import ErrorPage from "../components/ErrorPage";
import SignIn from "../components/SignIn";
import { AuthLayout } from "../components/AuthLayout";
import { DeviseLayout } from "../components/DeviseLayout";
import { ProtectedLayout } from "../components/ProtectedLayout";
import { connectionsLoader } from "../loaders";
import Connections from "../components/Connections";
import Accounts from "../components/Accounts";
import { accountsLoader } from "../loaders/accountsLoader";
import Transactions from "../components/Transactions";
import { transactionsLoader } from "../loaders/transactionsLoader";
import { newConnectionLoader } from "../loaders/newConnectionLoader";
import { NewConnection } from "../components/NewConnection";
import SignUp from "../components/SignUp";
import { signInLoader } from "../loaders/signInLoader";

export default createBrowserRouter(
  createRoutesFromElements(
    <Route element={<AuthLayout />}>
      <Route errorElement={<ErrorPage />}>
        <Route element={<ProtectedLayout />}>
          <Route path="/" element={<App />} errorElement={<ErrorPage />}>
            <Route
              index={true}
              element={<Connections />}
              loader={connectionsLoader}
            />
            <Route
              path={`/connections/:connectionId/accounts`}
              element={<Accounts />}
              loader={accountsLoader}
            />
            <Route
              path={`/connections/:connectionId/accounts/:accountId`}
              element={<Transactions />}
              loader={transactionsLoader}
            />
            <Route
              path="/connections/new"
              loader={newConnectionLoader}
              element={<NewConnection />}
            />
          </Route>
        </Route>
        <Route path="/users" element={<DeviseLayout />}>
          <Route path="login" element={<SignIn />} loader={signInLoader} />
          <Route path="sign_up" element={<SignUp />} />
        </Route>
      </Route>
    </Route>
  )
);
