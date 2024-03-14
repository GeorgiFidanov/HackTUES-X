import React from "react";

function StyledInput(props) {
  const { value, setValue, isPassword } = props;

  return (
    <input
      onChange={(e) => setValue(e.target.value)}
      className="border box-border rounded-lg py-4 px-2 focus:outline-none focus:ring-blue-500 focus:ring-2 bg-neutral-50"
      type={isPassword && "password"}
      required
      placeholder={value}
    />
  );
}

export default StyledInput;
