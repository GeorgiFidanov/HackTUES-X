import React, { useContext, useEffect, useState } from "react";
import { Outlet } from "react-router-dom";
import { IoStatsChart } from "react-icons/io5";
import { GiSaltShaker } from "react-icons/gi";
import { MdNoiseAware } from "react-icons/md";
import { FaWater } from "react-icons/fa";
import { FaTemperatureThreeQuarters } from "react-icons/fa6";
import { CiLogout } from "react-icons/ci";
import Dropdown from "./Dropdown";
import DropdownChoice from "./DropdownChoice";
import NavButton from "./NavButton";
import axios from "../bootstrap";
import { DeviceContext } from "../context/DeviceContext";
import logo from "../assets/icon_2x-removebg-preview.png";
import useAuth from "../hooks/useAuth";

function Sidebar() {
  const { deviceId, setDeviceId } = useContext(DeviceContext);
  const [devices, setDevices] = useState([]);
  const [device, setDevice] = useState("");

  const { logout } = useAuth();

  useEffect(() => {
    const handleGet = async () => {
      const res = await axios.get("/api/devices");
      setDevices(res.data);
    };

    handleGet();
  }, []);

  const handleLogout = (e) => {
    e.preventDefault();
    logout();
  };

  return (
    <div className="h-[100vh] bg-primary w-[280px] px-6 py-6 text-neutral-200 fixed">
      <img src={logo} width={64} height={64} />
      <Dropdown name={device ? device : "No device selected"}>
        {devices.map((d) => (
          <DropdownChoice
            key={d.id}
            name={d.name}
            handleChange={(e) => {
              setDeviceId(d.id);
              setDevice(d.name);
            }}
          />
        ))}
      </Dropdown>
      <hr className="border-neutral-500" />
      <NavButton to="/" label="Overview" icon={<IoStatsChart />} />
      <NavButton to="/salinity" label="Salinity" icon={<GiSaltShaker />} />
      <NavButton to="/murkiness" label="Murkiness" icon={<FaWater />} />
      <NavButton to="/noise" label="Noise" icon={<MdNoiseAware />} />
      <NavButton
        to="/temperature"
        label="Temperature"
        icon={<FaTemperatureThreeQuarters />}
      />
      <button
        onClick={handleLogout}
        className="flex flex-row w-full gap-5 items-center hover:bg-secondary mt-5 rounded-lg px-4 py-2"
      >
        <CiLogout />
        <h1>Log out</h1>
      </button>
    </div>
  );
}

export default Sidebar;
