import React, { FC } from "react";
import { useLoaderData } from "react-router-dom";

export const NewConnection: FC = () => {
  const { redirectUrl } = useLoaderData() as { redirectUrl: string };

  window.location.href = redirectUrl;
  return null;
}
