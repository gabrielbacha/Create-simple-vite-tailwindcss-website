#!/bin/bash

mkdir vite-project
cd vite-project

mkdir src
cd src
mkdir partials
mkdir sass
touch index.html
touch main.js
touch style.css 
cd partials
touch body.hbs
cd ..
cd sass
touch style-scss.scss
cd ..
cd ..

npm init -y
jq '. + {"type":"module"}' package.json > temp.json && mv temp.json package.json

npm install vite handlebars vite-plugin-handlebars vite-plugin-live-reload sass --save-dev

jq '.scripts += {"dev": "vite", "build": "vite build", "preview": "vite preview", "sass": "sass src/sass:src"}' package.json > temp.json && mv temp.json package.json

echo "import { defineConfig } from 'vite';
import handlebars from 'vite-plugin-handlebars';
import liveReload from 'vite-plugin-live-reload';

export default defineConfig({
    root: 'src/',
    base: './',
    server: {  
        host: true, // Open to local network and display URL
        open: !('SANDBOX_URL' in process.env || 'CODESANDBOX_HOST' in process.env),
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
    ],
    css: {
        preprocessorOptions: {
            scss: {
                additionalData: \`@import 'src/style.scss';\`,
                includePaths: ['src/'],
            },
        },
    },
});" > vite.config.js


# Update index.html
echo "<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Project Title</title>
    <link rel="stylesheet" href="./style-scss.css">    
    <link rel="stylesheet" href="./style.css">    
</head>
<body>

{{> body}}

<script type="module" src="./main.js"></script>
</body>
</html>
" > src/index.html

# Update body.hbs
echo '<h1 class="hello-world">Hello</h1>
' > src/partials/body.hbs

# Update style.css
echo ".hello-world{
    text-transform: uppercase;
}
" > src/style.css

# npm run dev to start the project
npm run dev