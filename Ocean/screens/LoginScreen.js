import React, { useEffect, useState } from 'react';
import { View, Text, Button, Image, TouchableOpacity } from 'react-native';
import { loginStyles } from '../components/loginStyles';
import { TextInput} from 'react-native-gesture-handler';
import { useNavigation } from '@react-navigation/native';
import axios from "axios"

const LoginScreen = () => {
  const navigation = useNavigation();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleGet = async() =>{
    const res = await axios.get("http://172.20.10.3:8000/login", {email:email, password:password})
    console.log(res.data)
  }

  /*const handleLogin = () => {
    // Implement login logic
    console.log('Email:', email);
    console.log('Password:', password);

    //handleGet();

    navigation.navigate('WelcomeScreen');
  };*/

  const handleLogin = async () => {
    try {
      // Implement login logic
      console.log('Email:', email);
      console.log('Password:', password);
  
      // Call API to authenticate user
      //const res = await axios.get("http://172.20.10.3:8000/login", { email, password });
  
      // Navigate to WelcomeScreen regardless of authentication status
      navigation.navigate('WelcomeScreen');
    } catch (error) {
      console.error('Error during login:', error);
    }
  };

  return (
    <View style={loginStyles.container}>
      <Image
        source={require('../assets/logo.png')}
        style={loginStyles.logo}
      />
      <Text style={loginStyles.label}>Email</Text>
      <TextInput
        style={loginStyles.input}
        onChangeText={text => setEmail(text)}
        value={email}
        placeholder="Enter your email"
        placeholderTextColor="#989898"
        keyboardType="email-address"
      />
      <Text style={loginStyles.label}>Password</Text>
      <TextInput
        style={loginStyles.input}
        onChangeText={text => setPassword(text)}
        value={password}
        placeholder="Enter your password"
        secureTextEntry
      />
      <TouchableOpacity style={loginStyles.button} onPress={handleLogin}>
        <View style={loginStyles.buttonContent}>
          <Text style={loginStyles.buttonText}>Login</Text>
        </View>
      </TouchableOpacity>
    </View>
  );
};

export default LoginScreen;