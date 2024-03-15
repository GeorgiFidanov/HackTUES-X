import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import {
  RouterProvider,
  createBrowserRouter,
  useNavigate,
  redirect,
} from "react-router-dom";
import Login from "./pages/Login";
import Layout from "./components/Layout";
import Register from "./pages/Register";
import Home from "./pages/Home";
import useAuth from "./hooks/useAuth";
import axios from "./bootstrap";
import Sidebar from "./components/Sidebar";
import Salinity from "./pages/Salinity";

const requireAuth = async () => {
  await axios.get("http://localhost:8000/api/check-auth").catch((e) => {
    throw redirect("/login");
  });
};

const router = createBrowserRouter([
  {
    element: <Layout />,
    children: [
      {
        path: "/",
        element: <Home />,
        loader: async () => {
          await requireAuth();
          return null;
        },
      },
      {
        path: "/salinity",
        element: <Salinity />,
        loader: async () => {
          await requireAuth();
          return "salinity";
        },
      },
      {
        path: "/murkiness",
        element: <Salinity />,
        loader: async () => {
          await requireAuth();
          return "murkiness";
        },
      },
      {
        path: "/noise",
        element: <Salinity />,
        loader: async () => {
          await requireAuth();
          return "noise";
        },
      },
      {
        path: "/temperature",
        element: <Salinity />,
        loader: async () => {
          await requireAuth();
          return "temperature";
        },
      },
    ],
  },
  {
    path: "/login",
    element: <Login />,
  },
  {
    path: "/register",
    element: <Register />,
  },
]);

ReactDOM.createRoot(document.getElementById("root")).render(
  <RouterProvider router={router} />
);
