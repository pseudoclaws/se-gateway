import React from "react";
import { Navigate, Outlet } from "react-router-dom";
import { useSelector } from "react-redux";
import { RootState } from "../redux/store";
import { CurrentUserProps } from "../redux/types";

export const DeviseLayout = () => {
  const { currentUser } = useSelector<
    RootState,
    { currentUser: CurrentUserProps }
  >((state) => state.reduxTokenAuth);

  if (currentUser.isSignedIn) {
    return <Navigate to="/" />;
  }

  return (
    <>
      <Outlet />
    </>
  );
};
