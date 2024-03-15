import React, { useEffect } from "react";
import "../index.css";
import { Outlet } from "react-router-dom";
import Sidebar from "./Sidebar";

function Layout() {
  return (
    <div>
      <Sidebar />
      <div className="ml-[230px]">
        <Outlet />
      </div>
    </div>
  );
}

export default Layout;
