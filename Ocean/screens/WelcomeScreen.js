import React from 'react';
import { View, Text, StyleSheet, Button } from 'react-native';

const WelcomeScreen = ({ navigation }) => {
  const handleLogout = () => {

  };

  return (
    <View style={styles.container}>
      <Text style={styles.welcomeText}>Welcome to Your App!</Text>
      <Button title="Logout" onPress={handleLogout} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  welcomeText: {
    fontSize: 24,
    marginBottom: 20,
  },
});

export default WelcomeScreen;