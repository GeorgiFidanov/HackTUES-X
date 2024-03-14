import { useState } from "react";
import axios from "../bootstrap";
import ContainerCard from "../components/ContainerCard";

function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    await axios.get("/sanctum/csrf-cookie");
    const res = await axios.post("/login", {
      email: email,
      password: password,
    });
  };

  const handleUser = async (e) => {
    e.preventDefault();
    const r = await axios.get("/api/user");
    console.log(r);
  };

  return (
    <ContainerCard>
      <div className="flex flex-col justify-center items-center gap-5">
        <h1 className="text-3xl font-light">Login</h1>
        <form
          className="flex flex-col gap-5 px-6 py-12"
          onSubmit={handleSubmit}
        >
          <input
            onChange={(e) => setEmail(e.target.value)}
            className="border rounded-lg py-4 px-2"
            placeholder="Email"
          />
          <input
            onChange={(e) => setPassword(e.target.value)}
            className="border rounded-lg py-4 px-2"
            placeholder="Password"
          />
        </form>
        <button
          onClick={handleSubmit}
          className="bg-neutral-900 px-12 py-2 text-neutral-100 rounded-lg"
        >
          Login
        </button>
      </div>
    </ContainerCard>
  );
}

export default Login;
