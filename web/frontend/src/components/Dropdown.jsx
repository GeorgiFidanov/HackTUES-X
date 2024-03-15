import React, { useRef, useState } from "react";
import useClickOutside from "../hooks/useClickOutside";
import { RiArrowDropDownLine } from "react-icons/ri";

const Dropdown = ({ name, children }) => {
  const [isOpen, setIsOpen] = useState(false);
  const menuRef = useRef(null);
  useClickOutside(menuRef, () => setIsOpen(false));

  return (
    <>
      <button
        className="flex p-2 w-full bg-secondary rounded-xl h-16 my-6 justify-between px-4 items-center"
        onClick={(e) => {
          e.preventDefault();
          setIsOpen(!isOpen);
        }}
      >
        <p>{name}</p>
        <RiArrowDropDownLine />
      </button>
      <div
        ref={menuRef}
        className={
          !isOpen
            ? "hidden"
            : "bg-secondary z-10 absolute rounded-lg w-[230px] border-2 border-neutral-600 ring-2 ring-white ring-opacity-10 h-36 overflow-auto"
        }
      >
        {children.map((child) =>
          React.cloneElement(child, {
            key: child.props.name,
            setIsOpen,
            ...child.props,
          })
        )}
      </div>
    </>
  );
};

export default Dropdown;
