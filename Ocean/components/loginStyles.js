import { StyleSheet } from 'react-native';

export const loginStyles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: '#AEC6CF',
    paddingHorizontal: 20,
    paddingTop: 170,
  },
  label: {
    alignSelf: 'flex-start',
    marginBottom: 5,
    fontWeight: 'bold',
  },
  input: {
    height: 40,
    width: '100%',
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 10,
    paddingHorizontal: 10,
    backgroundColor: '#EEEEEE',
    borderRadius: 7,
  },
  logo: {
    width: 150, 
    height: 150, 
  },
  button: {
    borderRadius: 50, 
    overflow: 'hidden', 
  },
  buttonContent: {
    backgroundColor: '#5E8D9F', // Button background color
    paddingVertical: 12, 
    paddingHorizontal: 24, 
  },
  buttonText: {
    color: '#FFFFFF',
    fontWeight: 'bold', 
    fontSize: 16,
  },
});