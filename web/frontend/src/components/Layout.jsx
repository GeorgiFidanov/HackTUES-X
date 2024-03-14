import React from "react";
import "../index.css";
import { Outlet } from "react-router-dom";

function Layout() {
  return (
    <div className="flex pt-32 justify-center items-center flex-1">
      <Outlet />
    </div>
  );
}

export default Layout;
