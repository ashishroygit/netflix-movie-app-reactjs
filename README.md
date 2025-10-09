# 🎬 Netflix Movie App - React Enterprise

![React](https://img.shields.io/badge/React-18.0+-blue) ![Vite](https://img.shields.io/badge/Vite-7.1+-lightgreen) ![TailwindCSS](https://img.shields.io/badge/TailwindCSS-4.1+-blue) ![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-orange) ![Docker](https://img.shields.io/badge/Docker-Multi--Stage-blue)

> 🚀 **Enterprise-grade Netflix-inspired movie discovery app with modern React architecture**  
> 🎯 **Production-ready streaming platform built with React 19, Vite, TailwindCSS, Appwrite, and AWS infrastructure**

## 📚 Table of Contents

- [Features](#-features)
- [Demo](#-demo)
- [Architecture](#%EF%B8%8F-architecture)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Configuration](#%EF%B8%8F-configuration)
- [Technology Stack](#%EF%B8%8F-technology-stack)
- [API Documentation](#-api-documentation)
- [Deployment](#-deployment)
- [Contributing](#-contributing)
- [Troubleshooting](#-troubleshooting)
- [Roadmap](#-roadmap--milestones)
- [License](#-license)

## 🚀 Features

- 🎬 **Netflix-Inspired UI**: Sleek, responsive design with modern streaming platform aesthetics
- 🔍 **Advanced Search**: Real-time movie search with intelligent filtering and suggestions
- 📱 **Responsive Design**: Perfect experience across desktop, tablet, and mobile devices
- ☁️ **Cloud-Native Deployment**: Full AWS integration with ECS Fargate and Blue/Green deployments
- 🚀 **Modern Tech Stack**: React 19, Vite 7, TailwindCSS 4, and cutting-edge frontend technologies
- 🔒 **Secure Backend**: Appwrite integration for user management and data persistence
- 📊 **Production Monitoring**: Health checks, logging, and error tracking capabilities
- 🐳 **Containerized**: Multi-stage Docker builds for optimized production deployments
- 🔄 **CI/CD Ready**: Automated testing, building, and deployment workflows

## 🎬 Demo

> **Live Demo**: Coming Soon  
> **Screenshots**: Available in `/docs/screenshots/`

### Sample Movie Discovery:

```
🎭 User searches: "action movies 2024"

🎬 App displays:
- Grid of action movies with posters
- Movie ratings and release dates
- Quick preview on hover
- Detailed movie information modal

🎯 Features: Real-time search, responsive cards, smooth animations
```

## 🏗️ Architecture

### System Flow

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│   React UI  │◄──►│ Vite Server  │◄──►│  Appwrite   │
│  (Browser)  │    │   (Dev/Prod) │    │  Backend    │
└─────────────┘    └──────┬───────┘    └─────────────┘
                          │
                          ▼
                   ┌──────────────┐
                   │  Movie APIs  │
                   │ (TMDB/OMDB)  │
                   └──────────────┘
```

### AWS Deployment Flow

```
GitHub → Docker Build → ECR Registry → ECS Fargate → ALB → Users
                                          ▼
                                    CloudWatch Logs
```

### Data Flow

```
Movie Search → React Components → API Calls → Appwrite DB → Movie Data → UI Updates
```

## 📂 Project Structure

```
netflix-movie-app-reactjs/
├── 📁 .github/workflows/          # CI/CD automation (future)
├── 📁 infra/                      # AWS Infrastructure as Code
│   ├── baseline.yaml              # VPC, subnets, ECS cluster
│   └── app-stack.yaml             # Application deployment
├── 📁 public/                     # Static assets
│   ├── No-Poster.png              # Fallback movie poster
│   └── vite.svg                   # Vite logo
├── 📁 src/                        # Core application modules
│   ├── components/                # React components
│   │   ├── moviecard.jsx          # Movie display component
│   │   ├── search.jsx             # Search functionality
│   │   └── spinner.jsx            # Loading indicator
│   ├── assets/                    # App assets
│   │   ├── BG.png                 # Background image
│   │   ├── hero-img.png           # Hero section image
│   │   ├── logo.png               # App logo
│   │   ├── Search.svg             # Search icon
│   │   └── star.svg               # Rating star icon
│   ├── App.jsx                    # Main application component
│   ├── App.css                    # Application styles
│   ├── appwrite.js                # Appwrite configuration
│   ├── index.css                  # Global styles
│   └── main.jsx                   # Application entry point
├── 📄 Dockerfile                  # Multi-stage container build
├── 📄 nginx.conf                  # Production web server config
├── 📄 deploy.ps1                  # Windows deployment script
├── 📄 deploy.sh                   # Linux/Mac deployment script
├── 📄 cleanup.ps1                 # AWS resource cleanup script
├── 📄 package.json                # Dependencies and scripts
├── 📄 vite.config.js              # Vite configuration
├── 📄 eslint.config.js            # Code linting rules
├── 📄 index.html                  # HTML template
└── 📄 README.md                   # Documentation
```

## 📋 Prerequisites

- **Node.js**: 18.0 or higher
- **Memory**: Minimum 4GB RAM (8GB recommended for development)
- **Storage**: 2GB free space for dependencies and builds
- **API Keys**:
  - Appwrite project setup (free tier available)
  - Movie database API key (TMDB/OMDB)
- **Optional**: Docker for containerized deployment
- **AWS Account**: For production deployment

## 🚀 Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/ashishroygit/netflix-movie-app-reactjs.git
cd netflix-movie-app-reactjs
```

### 2. Setup Environment

```bash
# Using npm
npm install

# Or using yarn
yarn install

# Or using pnpm
pnpm install
```

### 3. Environment Configuration

Create a `.env.local` file in the root directory:

```env
# Appwrite Configuration
VITE_APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
VITE_APPWRITE_PROJECT_ID=your_project_id_here
VITE_APPWRITE_DATABASE_ID=your_database_id
VITE_APPWRITE_COLLECTION_ID=your_collection_id

# Movie API Configuration
VITE_MOVIE_API_KEY=your_movie_api_key_here
VITE_MOVIE_API_URL=https://api.themoviedb.org/3

# Optional Configuration
VITE_APP_NAME="Netflix Movie App"
VITE_APP_VERSION=1.0.0
```

### 4. Initialize Appwrite Backend

```bash
# Install Appwrite CLI (if not already installed)
npm install -g appwrite-cli

# Login to Appwrite
appwrite login

# Initialize project
appwrite init project
```

### 5. Launch Development Server

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

🎉 **Success!** Visit [http://localhost:5173](http://localhost:5173) to start browsing movies

## ⚙️ Configuration

### Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| VITE_APPWRITE_ENDPOINT | ✅ Yes | - | Appwrite server endpoint |
| VITE_APPWRITE_PROJECT_ID | ✅ Yes | - | Appwrite project identifier |
| VITE_APPWRITE_DATABASE_ID | ✅ Yes | - | Database ID for movie data |
| VITE_MOVIE_API_KEY | ✅ Yes | - | Movie database API key |
| VITE_MOVIE_API_URL | ❌ No | TMDB API | Movie API base URL |
| VITE_APP_NAME | ❌ No | Netflix Movie App | Application name |

### Advanced Configuration

**Vite Settings** (in `vite.config.js`):

```javascript
// Customize build and dev server
export default defineConfig({
  plugins: [react(), tailwind()],
  server: {
    port: 5173,
    host: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true
  }
})
```

## 🏗️ Technology Stack

### Core Technologies

| Component | Technology | Purpose |
|-----------|------------|---------|
| Frontend Framework | React 19.1.1 | User interface components |
| Build Tool | Vite 7.1.4 | Fast development and building |
| Styling | TailwindCSS 4.1.13 | Utility-first CSS framework |
| Backend Service | Appwrite 19.0.0 | Database and user management |
| State Management | React Hooks | Component state management |
| Routing | React Router (planned) | Client-side navigation |

### Infrastructure & DevOps

| Component | Technology | Purpose |
|-----------|------------|---------|
| Containerization | Docker | Application packaging |
| Cloud Platform | AWS (ECS, ECR, ALB) | Production deployment |
| Infrastructure | CloudFormation | Infrastructure as Code |
| Web Server | Nginx Alpine | Production static serving |
| Monitoring | AWS CloudWatch | Logging and metrics |

### Key Dependencies

```json
{
  "dependencies": {
    "react": "^19.1.1",
    "react-dom": "^19.1.1",
    "appwrite": "^19.0.0",
    "react-use": "^17.6.0"
  },
  "devDependencies": {
    "vite": "^7.1.4",
    "@vitejs/plugin-react": "^5.0.2",
    "tailwindcss": "^4.1.13",
    "@tailwindcss/vite": "^4.1.13",
    "eslint": "^9.33.0"
  }
}
```

## 📡 API Documentation

### Endpoints

#### Health Check

```
GET /health
```

Response:
```json
{
  "status": "healthy",
  "timestamp": "2025-10-08T12:00:00Z",
  "version": "1.0.0"
}
```

#### Movie Search Interface

```
GET /
```

Returns the main movie discovery interface.

#### Movie Data API (via Appwrite)

**Search Movies:**
```javascript
// Using Appwrite SDK
const movies = await databases.listDocuments(
  DATABASE_ID,
  COLLECTION_ID,
  [Query.search('title', searchTerm)]
);
```

**Response:**
```json
{
  "documents": [
    {
      "title": "Movie Title",
      "poster": "https://image.tmdb.org/poster.jpg",
      "rating": 8.5,
      "year": 2024,
      "genre": "Action"
    }
  ],
  "total": 150
}
```

### Error Handling

```json
{
  "error": "Movie not found",
  "code": 404,
  "timestamp": "2025-10-08T12:00:00Z"
}
```

## 📦 Deployment

### Local Development

```bash
# Development server with hot reload
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

### Docker Deployment

```bash
# Build multi-stage Docker image
docker build -t netflix-movie-app .

# Run container locally
docker run -p 80:80 netflix-movie-app

# Test the application
curl http://localhost
```

### AWS Production Deployment

#### Prerequisites

- AWS CLI configured
- ECR repository created (automatically created by deployment scripts)
- Docker installed and running
- Proper AWS IAM permissions

#### One-Click Deployment

**For Windows (PowerShell):**
```powershell
# Run the automated deployment script
.\deploy.ps1

# Optional: Specify custom region
.\deploy.ps1 -Region "us-west-2"
```

**For Linux/Mac (Bash):**
```bash
# Make script executable and run
chmod +x deploy.sh
./deploy.sh
```

The deployment script will automatically:
- Create ECR repository if needed
- Build React application
- Build and push Docker image
- Deploy AWS infrastructure
- Provide the final application URL

#### Manual Deployment Steps

If you prefer manual deployment:

1. **Build and Push to ECR:**

```bash
# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com

# Build and tag image
docker build -t netflix-movie-app .
docker tag netflix-movie-app:latest <account>.dkr.ecr.us-east-1.amazonaws.com/netflix-movie-app:latest

# Push to ECR
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/netflix-movie-app:latest
```

2. **Deploy Infrastructure:**

```bash
# Deploy baseline infrastructure (VPC, subnets, ECS cluster)
aws cloudformation deploy \
  --template-file infra/baseline.yaml \
  --stack-name netflix-baseline \
  --capabilities CAPABILITY_IAM

# Deploy application stack
aws cloudformation deploy \
  --template-file infra/app-stack.yaml \
  --stack-name netflix-app \
  --parameter-overrides ImageUri=<account>.dkr.ecr.us-east-1.amazonaws.com/netflix-movie-app:latest \
  --capabilities CAPABILITY_IAM
```

#### Manual Deployment

The infrastructure includes:

- **VPC with public/private subnets**
- **Application Load Balancer**
- **ECS Fargate service**
- **Auto-scaling capabilities**
- **CloudWatch logging**

#### Resource Cleanup

To avoid AWS charges when done testing:

**Windows (PowerShell):**
```powershell
# Clean up all AWS resources
.\cleanup.ps1
```

**Linux/Mac (Bash):**
```bash
# Clean up all AWS resources (create similar cleanup.sh if needed)
# Or manually delete CloudFormation stacks:
aws cloudformation delete-stack --stack-name netflix-app
aws cloudformation delete-stack --stack-name netflix-baseline
```

### Environment-Specific Configuration

| Environment | Branch | Infrastructure | URL |
|-------------|--------|----------------|-----|
| Development | develop | Local/Docker | http://localhost:5173 |
| Staging | staging | AWS ECS | https://staging.netflix-app.example.com |
| Production | main | AWS ECS | https://netflix-app.example.com |

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

### Development Setup

```bash
# Fork and clone the repository
git clone https://github.com/your-username/netflix-movie-app-reactjs.git
cd netflix-movie-app-reactjs

# Create a feature branch
git checkout -b feature/your-feature-name

# Install dependencies
npm install

# Start development server
npm run dev

# Run tests (when available)
npm test

# Run linting
npm run lint
```

### Code Standards

- Follow React best practices and hooks patterns
- Use TypeScript for type safety (migration planned)
- Write meaningful component and function names
- Add PropTypes or TypeScript interfaces
- Update documentation for component changes

### Pull Request Process

1. Update README.md with details of changes
2. Add tests for new functionality (when test suite is available)
3. Ensure all linting passes
4. Update version numbers following semantic versioning
5. Submit pull request with detailed description

### Issue Reporting

- Use GitHub Issues for bug reports and feature requests
- Include browser details, error messages, and reproduction steps
- Tag issues appropriately (bug, enhancement, documentation, etc.)

## 🔧 Troubleshooting

### Common Issues

#### "Module not found" errors

```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

#### "Appwrite connection failed"

```bash
# Verify your Appwrite configuration in .env.local
export VITE_APPWRITE_ENDPOINT="https://cloud.appwrite.io/v1"
export VITE_APPWRITE_PROJECT_ID="your-project-id"

# Check Appwrite dashboard for correct project settings
```

#### "Build fails with Vite errors"

```bash
# Clear Vite cache
rm -rf node_modules/.vite
npm run dev

# Try different port if 5173 is occupied
npm run dev -- --port 3000
```

#### "Docker build fails"

```bash
# Ensure dist/ folder is built
npm run build

# Check Docker daemon is running
docker version

# Build with verbose output
docker build -t netflix-movie-app . --progress=plain
```

#### "AWS deployment fails"

```bash
# Verify AWS credentials
aws sts get-caller-identity

# Check CloudFormation events
aws cloudformation describe-stack-events --stack-name netflix-baseline

# Validate templates
aws cloudformation validate-template --template-body file://infra/baseline.yaml
```

### Performance Optimization

#### Slow Load Times

- Enable lazy loading for movie images
- Implement virtual scrolling for large movie lists
- Use React.memo for expensive components
- Optimize bundle size with Vite code splitting

#### Memory Issues

- Implement proper cleanup in useEffect hooks
- Use AbortController for API calls
- Optimize image sizes and formats

### Debugging Tips

```bash
# Enable Vite debug mode
DEBUG=vite:* npm run dev

# Check network requests in browser DevTools
# Monitor Appwrite real-time logs

# Check production build locally
npm run build && npm run preview
```

### Getting Help

- 📖 Check documentation in `/docs/` (coming soon)
- 🐛 Report issues on [GitHub](https://github.com/ashishroygit/netflix-movie-app-reactjs/issues)
- 💬 Join our Discord community (link coming soon)
- 📧 Email support: [support@netflix-movie-app.example.com](mailto:support@netflix-movie-app.example.com)

## 🏆 Roadmap & Milestones

### Completed ✅

- **October 2025**: Enterprise-grade initial release
- **October 2025**: AWS infrastructure setup with ECS Fargate
- **October 2025**: Multi-stage Docker implementation

### Upcoming 🚀

- **Q4 2025**: TypeScript migration for better type safety
- **Q4 2025**: Comprehensive test suite with Jest and Testing Library
- **Q1 2026**: User authentication and personalized recommendations
- **Q1 2026**: Movie watchlist and favorites functionality
- **Q2 2026**: Real-time chat and social features

### Future Vision 🔮

- Integration with streaming services APIs
- AI-powered movie recommendations
- Mobile app with React Native
- Progressive Web App (PWA) capabilities
- Multi-language support

## 👥 Team

### Core Team

- [Ashish Roy](https://github.com/ashishroygit) - Project Lead & Full-Stack Architecture
- Contributors Welcome - Join us in building the future of movie discovery!

### How to Join

We're looking for contributors in:

- 🎨 **Frontend Development** (React, CSS, UX/UI)
- ☁️ **Cloud Infrastructure** (AWS, Docker, CI/CD)
- 🔧 **Backend Development** (Node.js, Appwrite, APIs)
- 🎬 **Content & Design** (Movie data, UI/UX design)
- 🧪 **Quality Assurance** (Testing, automation)

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/ashishroygit/netflix-movie-app-reactjs) ![GitHub forks](https://img.shields.io/github/forks/ashishroygit/netflix-movie-app-reactjs) ![GitHub issues](https://img.shields.io/github/issues/ashishroygit/netflix-movie-app-reactjs) ![GitHub pull requests](https://img.shields.io/github/issues-pr/ashishroygit/netflix-movie-app-reactjs)

## ⚠️ Important Disclaimer

> 🎬 **ENTERTAINMENT NOTICE**: This application is for educational and entertainment purposes only. Movie data is sourced from public APIs and databases. This project is not affiliated with Netflix or any streaming service.
> 
> 📊 **Data Usage**: All movie information is used under fair use guidelines for educational projects.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### License Summary

- ✅ Commercial use allowed
- ✅ Modification allowed
- ✅ Distribution allowed
- ✅ Private use allowed
- ❌ Liability and warranty disclaimers apply

---

### 🌟 Star this project if you find it helpful! 🌟

Made with ❤️ by the React Community

⬆️ [Back to Top](#-netflix-movie-app---react-enterprise)
