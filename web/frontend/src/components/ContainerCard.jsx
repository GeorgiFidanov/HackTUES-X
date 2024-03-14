import React from "react";

function ContainerCard({ children }) {
  return (
    <div className="w-[50%] border rounded-lg flex flex-col py-16 px-5 justify-center items-center">
      {children}
    </div>
  );
}

export default ContainerCard;
