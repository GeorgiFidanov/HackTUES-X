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
import Stat from "./pages/Stat";

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
        element: <Stat />,
        loader: async () => {
          console.log("hello");
          await requireAuth();
          return { parameter: "salinity", domain: [0, 5] };
        },
      },
      {
        path: "/murkiness",
        element: <Stat />,
        loader: async () => {
          await requireAuth();
          return { parameter: "murkiness", domain: [0, 5] };
        },
      },
      {
        path: "/noise",
        element: <Stat />,
        loader: async () => {
          await requireAuth();
          return { parameter: "noise", domain: [0, 1] };
        },
      },
      {
        path: "/temperature",
        element: <Stat />,
        loader: async () => {
          await requireAuth();
          return { parameter: "temperature", domain: [20, 28] };
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
