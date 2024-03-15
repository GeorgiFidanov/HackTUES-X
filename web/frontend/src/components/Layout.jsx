import React, { useEffect, useState } from "react";
import "../index.css";
import { Outlet } from "react-router-dom";
import Sidebar from "./Sidebar";
import { DeviceContext } from "../context/DeviceContext";

function Layout() {
  const [deviceId, setDeviceId] = useState({});

  return (
    <div>
      <DeviceContext.Provider value={{ deviceId, setDeviceId }}>
        <Sidebar />
        <div className="ml-[280px]">
          <Outlet />
        </div>
      </DeviceContext.Provider>
    </div>
  );
}

export default Layout;
