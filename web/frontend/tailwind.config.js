/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    
    extend: {
      fontFamily:{
        primary: "DM Sans"
      },
      transitionProperty:{
        'width': 'width'
      },
      colors:{
        primary: '#1c2536',
        secondary: '#252e3e'
      },
    },
  },
  plugins: [],
}

