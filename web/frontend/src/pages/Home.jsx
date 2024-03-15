import React, { useEffect, useState } from "react";
import axios from "../bootstrap";

function Home() {
  const [device, setDevice] = useState({});

  useEffect(() => {
    const updateStorage = async () => {
      const res = await axios.get(
        "/api/device/" + localStorage.getItem("device")
      );
      setDevice(res.data);
    };

    window.addEventListener("storage", updateStorage);

    return () => {
      window.removeEventListener("storage", updateStorage);
    };
  }, []);

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center items-center gap-5 h-[100vh]">
      {device ? (
        <h1>{device.name}</h1>
      ) : (
        <h1>Please select a device to see data</h1>
      )}
    </div>
  );
}

export default Home;
