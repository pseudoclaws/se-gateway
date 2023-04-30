import React, { FC } from "react";
import { Link, useLoaderData } from "react-router-dom";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import { useSelector } from "react-redux";
import { GatewayState } from "../redux/types";

const Accounts: FC = () => {
  const { connectionId } = useLoaderData() as {
    connectionId: string;
  };

  const accounts = useSelector<GatewayState, any[]>(state => state.accounts);

  return (
    <Grid item xs={12}>
      <Paper sx={{ p: 2, display: "flex", flexDirection: "column" }}>
        <h1>Accounts of connection #{connectionId}</h1>
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>ID</TableCell>
                <TableCell>Nature</TableCell>
                <TableCell>Balance</TableCell>
                <TableCell>Currency Code</TableCell>
                <TableCell>Updated At</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {accounts.map((row) => (
                <TableRow
                  key={row.data.attributes.external_id}
                  sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                >
                  <TableCell component="th" scope="row">
                    <Link
                      to={`/connections/${row.data.attributes.connection_id}/accounts/${row.data.attributes.external_id}`}
                    >
                      {row.data.attributes.external_id}
                    </Link>
                  </TableCell>
                  <TableCell>{row.data.attributes.nature}</TableCell>
                  <TableCell>{row.data.attributes.balance}</TableCell>
                  <TableCell>{row.data.attributes.currency_code}</TableCell>
                  <TableCell>{row.data.attributes.updated_at}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Paper>
    </Grid>
  );
};

export default Accounts;
