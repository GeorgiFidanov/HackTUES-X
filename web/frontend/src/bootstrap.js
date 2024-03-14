import axios from 'axios';
import { redirect } from 'react-router-dom';
import {Cookies} from 'react-cookie';

const cookies = new Cookies()

axios.defaults.baseURL = "http://localhost:8000"
axios.defaults.withXSRFToken = true;

const updateAxios = () => {
    const token = cookies.get('token')
    if (token) {
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    } else {
        delete axios.defaults.headers.common['Authorization'];
    }
}

updateAxios()

window.addEventListener('storage', updateAxios)

export default axios