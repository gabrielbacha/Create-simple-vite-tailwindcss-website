#!/bin/bash

mkdir vite-project && cd vite-project

mkdir src && cd src && touch index.html && touch main.js
mkdir css && cd css && touch input.css && cd ..
mkdir partials && cd partials && touch body.hbs && cd ..
cd ..

touch gitignore
cat <<EOF >> .gitignore
.log
.DS_Store
.env
node_modules/
dist/
out/
EOF

npm init -y
jq '. + {"type":"module"}' package.json > temp.json && mv temp.json package.json

npm install vite handlebars vite-plugin-handlebars vite-plugin-live-reload tailwindcss concurrently vite-plugin-mkcert gh-pages --save-dev


jq '.scripts += {"dev":"concurrently \"npx tailwindcss -i ./src/css/input.css -o ./src/css/style.css --watch\" \"vite\"", "build": "vite build", "preview": "vite preview", "deploy": "gh-pages -d src/dist"}' package.json > temp.json && mv temp.json package.json

echo "import { defineConfig } from 'vite';
import handlebars from 'vite-plugin-handlebars';
import liveReload from 'vite-plugin-live-reload';
import mkcert from 'vite-plugin-mkcert'

export default defineConfig({
    root: 'src/',
    base: './', //ADD GITHUB REPO HERE
    server: {  
        host: true, // Open to local network and display URL
        open: !('SANDBOX_URL' in process.env || 'CODESANDBOX_HOST' in process.env),
        https: true,
    },
    watch: {
        include: './src/partials/**.html'
    },
    resolve: {
        alias: {
            '@': '/src',
        },
    },
    plugins: [
        handlebars({
            context: {},
            partialDirectory: './src/partials',
            helpers: {},
        }),
        liveReload(['**/*.hbs', '**/*.html']),
        mkcert(),
    ],
});" > vite.config.js

npx tailwindcss init && rm tailwind.config.js
echo "/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,js}', './src/partials/**/*.{html,js,hbs}'],
  theme: {
    extend: {},
  },
  plugins: [],
}" > tailwind.config.js


# Update index.html
echo '<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Project Title</title>
    <link rel="stylesheet" href="./css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

{{> body}}

<script type="module" src="./main.js"></script>
</body>
</html>
' > src/index.html

# Update body.hbs
echo '  <h1 class="text-3xl font-bold underline">
    Hello world!
  </h1>
' > src/partials/body.hbs

# Update input.css
echo "@tailwind base;
@tailwind components;
@tailwind utilities;
" > src/css/input.css

# npm run dev to start the project
npm run dev