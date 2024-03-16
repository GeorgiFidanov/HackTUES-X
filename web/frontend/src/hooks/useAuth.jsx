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
    window.dispatchEvent(new Event("storage"));
    navigate("/");
  };

  const register = async ({ ...props }) => {
    csrf();

    const res = await axios.post("/api/register", props);
    setToken("token", res.data.token);
    window.dispatchEvent(new Event("storage"));
    navigate("/");
  };

  const logout = async () => {
    csrf();

    await axios.get("/api/logout");
    removeToken();
    window.dispatchEvent(new Event("storage"));
    navigate("/login");
  };

  return { login, register, logout };
};

export default useAuth;
