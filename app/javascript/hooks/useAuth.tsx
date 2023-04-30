import * as React from "react";
import { useNavigate } from "react-router-dom";
import { useLocalStorage } from "./useLocalStorage";
import { createContext, useContext, useMemo } from "react";
interface AuthContextProps {
  currentUser: {
    isLoading: boolean;
    isSignedIn: boolean;
    attributes: {
      name: string;
    };
  };
}

const AuthContext = createContext<AuthContextProps>({
  currentUser: {
    isLoading: false,
    isSignedIn: false,
    attributes: {
      name: "",
    },
  },
});

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useLocalStorage("user", null);
  const navigate = useNavigate();

  // call this function when you want to authenticate the user
  // const login = async (data) => {
  //   setUser(data);
  //   navigate("/");
  // };

  // call this function to sign out logged in user
  // const logout = () => {
  //   setUser(null);
  //   navigate("/users/login", { replace: true });
  // };

  const value = useMemo(
    () => ({
      currentUser: user,
      // login,
      // logout,
    }),
    [user]
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  return useContext(AuthContext);
};
