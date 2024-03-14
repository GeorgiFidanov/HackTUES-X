import { useState } from "react";
import useAuth from "../hooks/useAuth";
import StyledInput from "../components/StyledInput";
import { Link } from "react-router-dom";

function Register() {
  const { register } = useAuth();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmationPassword, setConfirmationPassword] = useState("");
  const [errors, setErrors] = useState([]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    register({ name, email, password, confirmationPassword });
  };

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center items-center gap-5">
      <h1 className="text-3xl font-light">Register</h1>
      <form
        className="flex flex-col gap-5 py-12 w-[400px]"
        onSubmit={handleSubmit}
      >
        <StyledInput value="Name" setValue={setName} isPassword={false} />
        <StyledInput value="Email" setValue={setEmail} isPassword={false} />
        <StyledInput
          value="Password"
          setValue={setPassword}
          isPassword={true}
        />
        <StyledInput
          value="Confirm Password"
          setValue={setConfirmationPassword}
          isPassword={true}
        />
      </form>
      <button
        onClick={handleSubmit}
        className="bg-neutral-900 px-12 py-2 text-neutral-100 rounded-lg"
      >
        Login
      </button>
      <div className="flex justify-center flex-col items-center text-neutral-400 pt-4 gap-2">
        <Link to="/login">Already have an account?</Link>
      </div>
    </div>
  );
}

export default Register;
