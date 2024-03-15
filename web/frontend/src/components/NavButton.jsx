import React from "react";
import { Link } from "react-router-dom";

function NavButton({ to, label, icon }) {
  return (
    <Link
      to={to}
      className="flex flex-row gap-5 items-center hover:bg-secondary mt-5 rounded-lg px-4 py-2"
    >
      {icon}
      <h1>{label}</h1>
    </Link>
  );
}

export default NavButton;
