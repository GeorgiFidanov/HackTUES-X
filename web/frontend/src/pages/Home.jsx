import React, { useEffect } from "react";
import axios from "../bootstrap";

function Home() {
  useEffect(() => {
    const handleGet = async () => {
      const res = await axios.get("/api/esp");
      console.log(res.data);
    };

    handleGet();
  });

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center items-center gap-5">
      <h1>Home</h1>
    </div>
  );
}

export default Home;
