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

const Transactions: FC = () => {
  const { accountId } = useLoaderData() as {
    accountId: string;
  };

  const transactions = useSelector<GatewayState, any[]>(
    (state) => state.transactions
  );

  return (
    <Grid item xs={12}>
      <Paper sx={{ p: 2, display: "flex", flexDirection: "column" }}>
        <h1>Transactions of account #{accountId}</h1>
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>ID</TableCell>
                <TableCell>Mode</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Made on</TableCell>
                <TableCell>Amount</TableCell>
                <TableCell>Currency Code</TableCell>
                <TableCell>Description</TableCell>
                <TableCell>Updated At</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {transactions.map((row) => (
                <TableRow
                  key={row.data.attributes.external_id}
                  sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                >
                  <TableCell component="th" scope="row">
                    {row.data.attributes.external_id}
                  </TableCell>
                  <TableCell>{row.data.attributes.mode}</TableCell>
                  <TableCell>{row.data.attributes.status}</TableCell>
                  <TableCell>{row.data.attributes.made_on}</TableCell>
                  <TableCell>{row.data.attributes.amount}</TableCell>
                  <TableCell>{row.data.attributes.currency_code}</TableCell>
                  <TableCell>{row.data.attributes.description}</TableCell>
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

export default Transactions;
