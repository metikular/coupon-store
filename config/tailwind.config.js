const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  darkMode: 'media',
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        // Normal colors
        primary: '#FCE57C',
        'primary-dark': '#FFD200',
        'grey-foreground': '#777777',
        'grey-background': '#efefef',
        'grey-page': '#fafafa',
        'grey-support': '#cccccc',
        'danger': '#ff8a8a',

        // Colors for dark mode
        'dark-primary': '#FCE57C',
        'dark-primary-dark': '#FFD200',
        'dark-grey-foreground': colors.slate['50'],
        'dark-grey-background': colors.slate['500'],
        'dark-grey-page': colors.slate['600'],
        'dark-grey-support': colors.slate['200'],
        'dark-danger': '#ff8a8a',
        'dark-white': colors.slate['700'],
        'dark-black': colors.slate['50'],
        'dark-gray-50': colors.slate['600'],
        'dark-gray-100': colors.slate['500']
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
