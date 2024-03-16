import React, { useContext, useEffect, useState } from "react";
import axios from "../bootstrap";
import StyledChart from "../components/StyledChart";
import { DeviceContext } from "../context/DeviceContext";

function Home() {
  const { deviceId, setDeviceId } = useContext(DeviceContext);
  const [data, setData] = useState([]);
  const [risk, setRisk] = useState(false);

  useEffect(() => {
    const updateStorage = async () => {
      const res = await axios.get("/api/device/" + deviceId);
      setData(res.data);
      console.log(res.data);
      const r = await axios.get("/api/airesponse/" + deviceId);
      r.data.forEach((obj) => {
        if (obj.type.toLowerCase() == "risk") {
          setRisk(true);
          console.log("here");
          return;
        }
      });
    };
    if (typeof deviceId !== "object") {
      updateStorage();
    }
  }, [deviceId]);

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center items-center gap-5 h-[100vh]">
      {deviceId ? (
        <>
          <div className="flex flex-row flex-wrap gap-4 justify-center">
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
            {risk && (
              <h1 className="text-red-700">
                The environment is at risk! Check if all parameters are within
                normal ranges!
              </h1>
            )}
          </div>
        </>
      ) : (
        <h1>Please select a device to see data</h1>
      )}
    </div>
  );
}

export default Home;
