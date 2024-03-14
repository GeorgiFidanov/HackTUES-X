import { useState } from "react";
import axios from "../bootstrap";
import ContainerCard from "../components/ContainerCard";
import useAuth from "../hooks/useAuth";
import StyledInput from "../components/StyledInput";
import { useNavigate, Link } from "react-router-dom";

function Login() {
  const { login, logout } = useAuth();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const nav = useNavigate();
  const [errors, setErrors] = useState([]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    login({ email, password });
  };

  const handleLogout = async (e) => {
    e.preventDefault();
    logout({ setErrors });
  };

  return (
    <div className="max-w-[820px] mx-auto flex flex-col justify-center items-center gap-5">
      <h1 className="text-3xl font-light">Login</h1>
      <form
        className="flex flex-col gap-5 py-12 w-[400px]"
        onSubmit={handleSubmit}
      >
        <StyledInput value="Email" setValue={setEmail} isPassword={false} />
        <StyledInput
          value="Password"
          setValue={setPassword}
          isPassword={true}
        />
      </form>
      <button
        onClick={handleSubmit}
        className="bg-neutral-900 px-12 py-2 text-neutral-100 rounded-lg"
      >
        Login
      </button>
      <button
        onClick={handleLogout}
        className="bg-neutral-900 px-12 py-2 text-neutral-100 rounded-lg"
      >
        Logout
      </button>
      <div className="flex justify-center flex-col items-center text-neutral-400 pt-4 gap-2">
        <Link to="/register">Don't have an account?</Link>
        <Link to="/register">Forgot your password?</Link>
      </div>
    </div>
  );
}

export default Login;
