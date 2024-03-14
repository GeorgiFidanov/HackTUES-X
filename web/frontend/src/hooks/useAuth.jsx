import { redirect, useNavigate } from "react-router-dom";
import axios from "../bootstrap";
import { useCookies } from "react-cookie";

const useAuth = () => {
  const [token, setToken, removeToken] = useCookies("token");
  const navigate = useNavigate();

  const csrf = async () => {
    await axios.get("/sanctum/csrf-cookie");
  };

  const login = async ({ ...props }) => {
    csrf();

    const res = await axios.post("/api/login", props);
    setToken("token", res.data.token);
    navigate("/");
  };

  const register = async ({ ...props }) => {
    csrf();

    const res = await axios.post("/api/register", props);
    setToken("token", res.data.token);
    navigate("/");
  };

  const logout = async ({ ...props }) => {
    csrf();

    await axios.post("/logout", props);
    removeToken();
    navigate("/login");
  };

  return { login, register, logout };
};

export default useAuth;
