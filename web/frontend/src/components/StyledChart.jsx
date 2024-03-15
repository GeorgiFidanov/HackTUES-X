import React from "react";
import {
  LineChart,
  CartesianGrid,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  Line,
} from "recharts";

function StyledChart({ data, type, parameter, domain }) {
  return (
    <LineChart width={400} height={250} data={data}>
      <CartesianGrid strokeDasharray="1 1" />
      <XAxis dataKey="timestamp" />
      <YAxis domain={[10, 15]} />
      <Tooltip />
      <Legend />
      <Line dataKey="temperature" stroke="#8884d8" activeDot={{ r: 8 }} />
    </LineChart>
  );
}

export default StyledChart;
