import React, {useState} from 'react';
import {View,TextInput,StyleSheet,Text,Image,StatusBar,Pressable} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import { Link } from 'expo-router';
const Login = ({navigation}) => {
	const [username, setUsername] = useState('');
	const [password, setPassword] = useState('');

	const handleSumbmit = () => {
		if (!username) {
		  alert('Please fill Email');
		  console.log(username, password);
		  return;
		}
		if (!password) {
		  alert('Please fill Password');
		  console.log(username, password);
		  return;
		}
		console.log(username, password);
	}

	return (
		<View style={styles.outer}>
		<View>
			<Image source={require('./Logo.png')} style={styles.logo} />
		</View>
	<KeyboardAwareScrollView
		enableOnAndroid={true}>
		
		<View style={styles.inner}>
			<Text style={styles.headerText}>Login</Text>
			<TextInput placeholder={"Username"} style={styles.textInput} onChange={(text) => setUsername(text)} value={username}/>
			<TextInput placeholder={"Password"} style={styles.textInput} onChange={(text) => setPassword(text)} value={password}/>
			<Pressable onPress={handleSumbmit}>
			<Text style={styles.submitBtn}>Login</Text>
			</Pressable>
			<Pressable onPress={() => navigation.navigate("Register")}>
				<Text style={styles.linkStyle}>  
					I don't have an account!
				</Text>
			</Pressable>
			
		</View>
		<StatusBar style="auto"/>
		</KeyboardAwareScrollView>
		</View>
	);
	};
	const styles = StyleSheet.create({
	outer: {
		flex: 1,
		backgroundColor: '#001764',
	},
	inner: {
		justifyContent: 'center',
		alignItems: 'center',
	},
	logo: {
		width: 80,
		height:80,
		margin:10
	},
	textInput: {
		width: 250,
		height: 44,
		padding: 10,
		marginTop: 20,
		marginBottom: 10,
		borderRadius: 4,
		backgroundColor: '#fff',
	},
	submitBtn: {
		backgroundColor: '#007bff',
		fontSize: 18,
		color: '#fff',
		width: 150,
		height: 44,
		padding: 10,
		marginTop: 20,
		borderRadius: 25,
		textAlign: 'center',
	},
	headerText:{
		color:'#fff',
		fontSize:40,
		fontWeight:'bold',
		marginBottom:10,
		marginTop:20,
	},
	linkStyle:{
		margin: 20,
		color:'#fff',
		fontSize:16,
		textAlign:'center'
	}
	});
export default Login;