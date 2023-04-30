import * as React from "react";
import { Outlet } from "react-router-dom";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import store, { AppDispatch } from "../redux/store";
import { verifyCredentials } from "../config/redux-token-auth-config";
import CssBaseline from "@mui/material/CssBaseline";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import Container from "@mui/material/Container";
import { Alert, Snackbar } from "@mui/material";
import { useDispatch, useSelector } from "react-redux";
import { GatewayState } from "../redux/types";
import { removeAlert } from "../redux/actions/alerts";

verifyCredentials(store);

const mdTheme = createTheme();

export default () => {
  const alerts = useSelector<GatewayState, any[]>((state) => state.alerts);
  const dispatch = useDispatch<AppDispatch>();
  return (
    <ThemeProvider theme={mdTheme}>
      <Box sx={{ display: "flex" }}>
        <CssBaseline />
        <Box
          component="main"
          sx={{
            backgroundColor: (theme) =>
              theme.palette.mode === "light"
                ? theme.palette.grey[100]
                : theme.palette.grey[900],
            flexGrow: 1,
            height: "100vh",
            overflow: "auto",
          }}
        >
          <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
            <Grid container spacing={3}>
              <Outlet />
            </Grid>
          </Container>
          {alerts.map((alert) => {
            return (
              <Snackbar
                anchorOrigin={{ vertical: "top", horizontal: "right" }}
                open={true}
                onClose={() => dispatch(removeAlert(alert.id))}
                autoHideDuration={6000}
                key={alert.id}
              >
                <Alert onClose={() => dispatch(removeAlert(alert.id))} severity={alert.severity} sx={{ width: '100%' }}>
                  {alert.message}
                </Alert>
              </Snackbar>
            )
          })}
        </Box>
      </Box>
    </ThemeProvider>
  );
};
