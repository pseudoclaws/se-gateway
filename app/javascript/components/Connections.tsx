import React, { FC } from "react";
import { Link } from "react-router-dom";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import { useDispatch, useSelector } from "react-redux";
import { GatewayState } from "../redux/types";
import IconButton from "@mui/material/IconButton";
import DeleteIcon from "@mui/icons-material/Delete";
import RefreshIcon from "@mui/icons-material/Refresh";
import SyncIcon from "@mui/icons-material/Sync";
import { AppDispatch } from "../redux/store";
import {
  destroyConnection,
  refreshConnection,
} from "../redux/actions/connections";

const Connections: FC = () => {
  const connections = useSelector<GatewayState, any[]>(
    (state) => state.connections
  );

  const dispatch = useDispatch<AppDispatch>();

  return (
    <>
      <Grid item xs={12}>
        <Paper sx={{ p: 2, display: "flex", flexDirection: "column" }}>
          <h1>Connections</h1>
          <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Customer ID</TableCell>
                  <TableCell>Customer identifier</TableCell>
                  <TableCell>Provider name</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell>Updated At</TableCell>
                  <TableCell></TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {connections.map((row) => (
                  <TableRow
                    key={row.data.attributes.external_id}
                    sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                  >
                    <TableCell component="th" scope="row">
                      <Link
                        to={`/connections/${row.data.attributes.external_id}/accounts`}
                      >
                        {row.data.attributes.external_id}
                      </Link>
                    </TableCell>
                    <TableCell>{row.data.attributes.customer_id}</TableCell>
                    <TableCell>
                      {row.data.attributes.customer_identifier}
                    </TableCell>
                    <TableCell>{row.data.attributes.provider_name}</TableCell>
                    <TableCell>{row.data.attributes.status}</TableCell>
                    <TableCell>{row.data.attributes.updated_at}</TableCell>
                    <TableCell>
                      <IconButton
                        aria-label="refresh"
                        onClick={() =>
                          dispatch(
                            refreshConnection({
                              connectionId: row.data.attributes.external_id,
                              reconnect: false,
                            })
                          )
                        }
                      >
                        <RefreshIcon />
                      </IconButton>
                      <IconButton
                        aria-label="reconnect"
                        onClick={() =>
                          dispatch(
                            refreshConnection({
                              connectionId: row.data.attributes.external_id,
                              reconnect: true,
                            })
                          )
                        }
                      >
                        <SyncIcon />
                      </IconButton>
                      <IconButton
                        aria-label="delete"
                        onClick={() =>
                          dispatch(
                            destroyConnection(row.data.attributes.external_id)
                          )
                        }
                      >
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Paper>
      </Grid>
      <Grid item xs={12}>
        <Paper
          sx={{
            p: 2,
            display: "flex",
            flexDirection: "column",
          }}
        >
          <Link to="/connections/new">Create connection</Link>
        </Paper>
      </Grid>
    </>
  );
};

export default Connections;
