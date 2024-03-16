import React, { useContext, useEffect, useState } from "react";
import StyledChart from "../components/StyledChart";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@mui/material";
import axios from "../bootstrap";
import { DeviceContext } from "../context/DeviceContext";
import { useLoaderData } from "react-router-dom";

function Salinity() {
  const { parameter, domain } = useLoaderData();
  const [rows, setRows] = useState([]);
  const { deviceId } = useContext(DeviceContext);

  console.log("hi");

  useEffect(() => {
    const updateStorage = async () => {
      if (!deviceId) {
        console.log(deviceId);
      } else {
        const res = await axios.get("/api/device/" + deviceId);
        setRows(res.data);
        console.log(rows);
      }
    };

    updateStorage();
  }, [deviceId]);

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center p-32 gap-5">
      {rows ? (
        <StyledChart
          type="big"
          parameter={parameter}
          data={rows}
          domain={domain}
        />
      ) : (
        <p>wait</p>
      )}
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>Timestamp</TableCell>
            <TableCell align="right">Device Name</TableCell>
            <TableCell align="right">{parameter}</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <TableRow key={row.id}>
              <TableCell scope="row">
                {new Date(row.created_at).toUTCString()}
              </TableCell>
              <TableCell align="right">{row.device_id}</TableCell>
              <TableCell align="right">{row[parameter]}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}

export default Salinity;
