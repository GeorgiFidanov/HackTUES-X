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

function Stat() {
  const { parameter, domain } = useLoaderData();
  const [rows, setRows] = useState([]);
  const { deviceId } = useContext(DeviceContext);
  const [risk, setRisk] = useState(false);

  useEffect(() => {
    const updateStorage = async () => {
      const res = await axios.get("/api/device/" + deviceId);
      setRows(res.data);
      const r = await axios.get("/api/airesponse/" + deviceId);
      r.data.forEach((obj) => {
        if (obj.type.toLowerCase() == "risk") {
          setRisk(true);
          return;
        }
      });
    };
    if (typeof deviceId !== "object") {
      updateStorage();
    }
  }, [deviceId]);

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center p-32 gap-5 items-center">
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
      {risk && (
        <h1 className="text-red-700">
          The environment is at risk! Check if all parameters are within normal
          ranges!
        </h1>
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

export default Stat;
