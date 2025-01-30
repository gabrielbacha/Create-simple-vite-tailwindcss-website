#!/bin/bash

cd "$(dirname "$0")"

mkdir vite-project && cd vite-project

mkdir src && cd src && touch index.html && touch main.js
mkdir css && cd css && touch input.css && cd ..
mkdir partials && cd partials && touch body.hbs && cd ..
cd ..
mkdir static

touch gitignore
cat <<EOF >> .gitignore
.log
.DS_Store
.env
.venv/
.next/
.yarn/
.vite/
venv/
node_modules/
dist/
out/
EOF


npm init -y
jq '. + {"type":"module"}' package.json > temp.json && mv temp.json package.json

npm install vite handlebars vite-plugin-handlebars vite-plugin-live-reload tailwindcss@3 concurrently vite-plugin-mkcert gh-pages --save-dev


jq '.scripts += {"dev":"concurrently \"npx tailwindcss -i ./src/css/input.css -o ./src/css/style.css --watch\" \"vite --host 0.0.0.0\"", "build": "vite build", "preview": "vite preview", "deploy": "gh-pages -d dist"}' package.json > temp.json && mv temp.json package.json

echo "import { defineConfig } from 'vite';
import handlebars from 'vite-plugin-handlebars';
import liveReload from 'vite-plugin-live-reload';
import mkcert from 'vite-plugin-mkcert'

export default defineConfig({
    root: 'src/',
    publicDir: '../static/',
    resolve: {
        alias: {
            '@': '/',
        },
    },
    base: './', //ADD GITHUB REPO HERE
    server: {  
        host: true, // Open to local network and display URL
        open: !('SANDBOX_URL' in process.env || 'CODESANDBOX_HOST' in process.env),
        https: true,
    },
    build:{
        outDir: '../dist'
    },
    watch: {
        include: './src/partials/**.html'
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
echo '  <div class="bg-white">
  <div class="relative isolate overflow-hidden bg-gradient-to-b from-indigo-100/20">
    <div class="mx-auto max-w-7xl pb-24 pt-10 sm:pb-32 lg:grid lg:grid-cols-2 lg:gap-x-8 lg:px-8 lg:py-40">
      <div class="px-6 lg:px-0 lg:pt-4">
        <div class="mx-auto max-w-2xl">
          <div class="max-w-lg">
            <img class="h-11" src="https://tailwindui.com/plus/img/logos/mark.svg?color=indigo&shade=500" alt="Your Company">
            <div class="mt-24 sm:mt-32 lg:mt-16">
              <a href="https://github.com/gabrielbacha/Jekyll-TailwindCSS-Starter-Template" class="inline-flex space-x-6">
                <span class="rounded-full bg-indigo-600/10 px-3 py-1 text-sm font-semibold leading-6 text-indigo-600 ring-1 ring-inset ring-indigo-600/10">Updates</span>
                <span class="inline-flex items-center space-x-2 text-sm font-medium leading-6 text-gray-600">
                  <span>Just shipped </span>
                  <svg class="h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
                  </svg>
                </span>
              </a>
            </div>
            <h1 class="mt-10 text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">Jekyll + Tailwind CSS starter template</h1>
            <p class="mt-6 text-lg leading-8 text-gray-600">This is a simple starter template for creating a Jekyll site with Tailwind CSS. It includes basic setup and configuration for Jekyll, a static site generator, and Tailwind CSS, a utility-first CSS framework.</p>
            <div class="mt-10 flex items-center gap-x-6">
              <a href="https://github.com/gabrielbacha/Jekyll-TailwindCSS-Starter-Template" class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Documentation</a>
              <a href="https://github.com/gabrielbacha/Jekyll-TailwindCSS-Starter-Template" class="text-sm font-semibold leading-6 text-gray-900">View on GitHub <span aria-hidden="true">→</span></a>
            </div>
          </div>
        </div>
      </div>
      <div class="mt-20 sm:mt-24 md:mx-auto md:max-w-2xl lg:mx-0 lg:mt-0 lg:w-screen">
        <div class="absolute inset-y-0 right-1/2 -z-10 -mr-10 w-[200%] skew-x-[-30deg] bg-white shadow-xl shadow-indigo-600/10 ring-1 ring-indigo-50 md:-mr-20 lg:-mr-36" aria-hidden="true"></div>
        <div class="shadow-lg md:rounded-3xl">
          <div class="bg-indigo-500 [clip-path:inset(0)] md:[clip-path:inset(0_round_theme(borderRadius.3xl))]">
            <div class="absolute -inset-y-px left-1/2 -z-10 ml-10 w-[200%] skew-x-[-30deg] bg-indigo-100 opacity-20 ring-1 ring-inset ring-white md:ml-20 lg:ml-36" aria-hidden="true"></div>
            <div class="relative px-6 pt-8 sm:pt-16 md:pl-16 md:pr-0">
              <div class="mx-auto max-w-2xl md:mx-0 md:max-w-none">
                <div class="w-screen overflow-hidden rounded-tl-xl bg-gray-900">
                  <div class="flex bg-gray-800/40 ring-1 ring-white/5">
                    <div class="-mb-px flex text-sm font-medium leading-6 text-gray-400">
                      <div class="border-b border-r border-b-white/20 border-r-white/10 bg-white/5 px-4 py-2 text-white">NotificationSetting.jsx</div>
                      <div class="border-r border-gray-600/10 px-4 py-2">App.jsx</div>
                    </div>
                  </div>
                  <div class="px-6 pb-14 pt-6">
                    <!-- Your code example -->
                  </div>
                </div>
              </div>
              <div class="pointer-events-none absolute inset-0 ring-1 ring-inset ring-black/10 md:rounded-3xl" aria-hidden="true"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="absolute inset-x-0 bottom-0 -z-10 h-24 bg-gradient-to-t from-white sm:h-32"></div>
  </div>
</div>
' > src/partials/body.hbs

# Update input.css
echo "@tailwind base;
@tailwind components;
@tailwind utilities;
" > src/css/input.css

# npm run dev to start the project
npm run dev