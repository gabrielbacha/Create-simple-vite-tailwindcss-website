# Vite + TailwindCSS + Handlebars Starter Template

A command-line script that creates a complete Vite project with TailwindCSS, Handlebars partials, live reload, and GitHub Pages deployment support.

## Features

- ⚡ **Vite** - Fast build tool and development server
- 🎨 **TailwindCSS** - Utility-first CSS framework
- 🧩 **Handlebars** - Template engine with partials support
- 🔥 **Live Reload** - Hot reload for all HTML/HBS files
- 📱 **Responsive** - Mobile-first design approach
- 🚀 **GitHub Pages** - Ready for static deployment
- 🔒 **HTTPS** - Local development with HTTPS via mkcert
- 📁 **Organized Structure** - Clean project layout

## Quick Start

1. **Make the script executable:**
   ```bash
   sudo chmod +x create-vite-app.sh
   ```

2. **Run the script:**
   ```bash
   ./create-vite-app.sh
   ```

3. **Start development:**
   ```bash
   cd vite-project
   npm run dev
   ```

## Project Structure

```
vite-project/
├── src/
│   ├── css/
│   │   ├── input.css          # TailwindCSS imports
│   │   └── style.css         # Compiled CSS (auto-generated)
│   ├── partials/
│   │   └── body.hbs          # Handlebars partials
│   ├── index.html            # Main template
│   └── main.js               # JavaScript entry point
├── static/                   # Static assets
├── dist/                     # Build output (auto-generated)
├── vite.config.js           # Vite configuration
├── tailwind.config.js       # TailwindCSS configuration
└── package.json             # Dependencies and scripts
```

## Available Scripts

- `npm run dev` - Start development server with live reload
- `npm run build` - Build for production
- `npm run preview` - Preview production build locally
- `npm run deploy` - Deploy to GitHub Pages

## Development Features

- **Hot Module Replacement** - Instant updates without page refresh
- **Handlebars Partials** - Reusable template components
- **TailwindCSS Watcher** - Real-time CSS compilation
- **HTTPS Localhost** - Secure local development environment
- **Network Access** - Access dev server from other devices

## Deployment

The template includes GitHub Pages deployment support. See `Deploy-to-github.md` for detailed deployment instructions.

## Tech Stack

- [Vite](https://vitejs.dev/) - Next generation frontend tooling
- [TailwindCSS](https://tailwindcss.com/) - Utility-first CSS framework
- [Handlebars](https://handlebarsjs.com/) - Semantic templating
- [vite-plugin-handlebars](https://github.com/alexlafroscia/vite-plugin-handlebars) - Handlebars integration
- [vite-plugin-live-reload](https://github.com/arnaudbarre/vite-plugin-live-reload) - Live reload functionality
- [gh-pages](https://github.com/tschaub/gh-pages) - GitHub Pages deployment