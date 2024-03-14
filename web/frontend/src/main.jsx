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
        path: "/login",
        element: <Login />,
      },
      {
        path: "/register",
        element: <Register />,
      },
      {
        path: "/",
        element: <Home />,
        loader: async () => {
          await requireAuth();
          return null;
        },
      },
    ],
  },
]);

ReactDOM.createRoot(document.getElementById("root")).render(
  <RouterProvider router={router} />
);
