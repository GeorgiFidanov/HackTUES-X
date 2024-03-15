import React from "react";
import {
  LineChart,
  CartesianGrid,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  Line,
  Label,
} from "recharts";

function StyledChart({ data, type, parameter, domain }) {
  return (
    <LineChart width={400} height={250} data={data.slice(0, 10)}>
      <CartesianGrid strokeDasharray="1 1" />
      <XAxis hide={true}></XAxis>
      <YAxis domain={domain} />
      <Tooltip />
      <Legend />
      <Line dataKey={parameter} stroke="#8884d8" dot={false} />
    </LineChart>
  );
}

export default StyledChart;
