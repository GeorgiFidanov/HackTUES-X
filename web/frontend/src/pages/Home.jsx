import React, { useEffect, useState } from "react";
import axios from "../bootstrap";
import StyledChart from "../components/StyledChart";

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
        <>
          <div className="flex flex-row flex-wrap gap-4">
            <StyledChart type="big" />
            <StyledChart type="big" />
            <StyledChart type="big" />
            <StyledChart type="big" />
          </div>
        </>
      ) : (
        <h1>Please select a device to see data</h1>
      )}
    </div>
  );
}

export default Home;
