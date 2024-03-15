import React, { useContext, useEffect, useState } from "react";
import axios from "../bootstrap";
import StyledChart from "../components/StyledChart";
import { DeviceContext } from "../context/DeviceContext";

function Home() {
  const { deviceId, setDeviceId } = useContext(DeviceContext);
  const [data, setData] = useState([]);

  useEffect(() => {
    const updateStorage = async () => {
      const res = await axios.get("/api/device/" + deviceId);
      setData(res.data);
    };
    if (deviceId) {
      updateStorage();
    }
  }, [deviceId]);

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center items-center gap-5 h-[100vh]">
      {deviceId ? (
        <>
          <div className="flex flex-row flex-wrap gap-4">
            <StyledChart
              type="big"
              parameter="temperature"
              domain={[20, 28]}
              data={data}
            />
            <StyledChart
              type="big"
              parameter="murkiness"
              domain={[0, 5]}
              data={data}
            />
            <StyledChart
              type="big"
              parameter="salinity"
              domain={[0, 1]}
              data={data}
            />
            <StyledChart
              type="big"
              parameter="noise"
              domain={[0, 1]}
              data={data}
            />
          </div>
        </>
      ) : (
        <h1>Please select a device to see data</h1>
      )}
    </div>
  );
}

export default Home;
