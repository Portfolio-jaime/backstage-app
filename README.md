# 🎓 Backstage DevOps Course - British Airways Training

A comprehensive Backstage training environment designed for DevOps engineers, featuring **persistent PostgreSQL data**, **GitHub integration**, and real-world examples.

## 📊 Estado Actual - FUNCIONANDO ✅

| Componente | Puerto | Estado | Descripción |
|------------|--------|---------|-------------|
| **Frontend** | 3000 | ✅ Activo | React UI con título personalizado |
| **Backend** | 7007 | ✅ Activo | Node.js API + plugins inicializados |
| **PostgreSQL** | 5432 | ✅ Activo | Base de datos persistente |
| **GitHub OAuth** | - | ✅ Configurado | Autenticación funcionando |
| **Entity Discovery** | - | ✅ Activo | Auto-discovery cada 30min |

**⚡ Inicio rápido**: Ver [QUICK_START.md](./QUICK_START.md) para comenzar en 5 minutos.

## 🚀 Quick Start

### Prerequisites

- **Docker** 20.10+ with Docker Compose 2.0+
- **GitHub Account** with personal access token
- **Node.js** 20+ (for local development)
- **Git** for version control

### 1. Setup Environment

```bash
# Navigate to Docker directory
cd Docker

# Run the course setup script
./setup-course.sh

# Follow the prompts to configure GitHub token
```

### 2. Start Services

```bash
# Start all services in background
docker-compose up -d

# Check service status
docker-compose ps

# View logs
docker-compose logs -f backstage-app
```

### 3. Access Backstage

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:7007
- **PostgreSQL**: localhost:5432

## 📋 What's Included

### 🏗️ Core Infrastructure

- **Backstage Frontend** - React-based developer portal UI
- **Backstage Backend** - Node.js API server with plugins
- **PostgreSQL** - Persistent database with data volumes
- **Example Python App** - Sample service with Kubernetes integration

### 🔌 Configured Plugins

- **Catalog** - Service and component discovery
- **Scaffolder** - Software template system
- **TechDocs** - Documentation site generator
- **Auth** - GitHub OAuth integration
- **Kubernetes** - Resource visualization
- **GitHub Integration** - Repository auto-discovery

### 📚 Course Materials

- **Comprehensive Documentation** - Architecture, setup, and troubleshooting
- **Hands-on Labs** - Practical exercises and examples  
- **Real-world Templates** - Production-ready scaffolding
- **Debug Tools** - Scripts and utilities for troubleshooting

## 🛠️ Configuration Files

```
├── Docker/
│   ├── docker-compose.yml     # Multi-service orchestration
│   ├── .env                   # Environment variables
│   ├── Dockerfile            # Backstage container image
│   ├── setup-course.sh       # Environment setup script
│   └── generate-secrets.sh   # Security configuration
├── backstage/
│   ├── app-config.yaml       # Main Backstage configuration
│   ├── catalog/              # Entity definitions
│   └── packages/             # Frontend and backend code
├── python-app-1/             # Example Python service
└── docs/                     # Course documentation
```

## 🔐 Security Configuration

### Environment Variables

The `.env` file contains sensitive configuration:

```bash
# GitHub Integration
GITHUB_TOKEN=your_github_personal_access_token
AUTH_GITHUB_CLIENT_ID=your_oauth_app_client_id  
AUTH_GITHUB_CLIENT_SECRET=your_oauth_app_secret

# Database
POSTGRES_USER=backstage
POSTGRES_PASSWORD=backstage_password
POSTGRES_DB=backstage

# Security
BACKEND_SECRET=generated_secure_secret
```

### GitHub Setup

1. **Personal Access Token** (for API access):
   - Go to GitHub → Settings → Developer settings → Personal access tokens
   - Generate token with scopes: `repo`, `read:org`, `read:user`, `user:email`
   - Add to `.env` as `GITHUB_TOKEN`

2. **OAuth App** (for user login):
   - Go to GitHub → Settings → Developer settings → OAuth Apps
   - Create new app with:
     - Homepage URL: `http://localhost:3000`
     - Callback URL: `http://localhost:7007/api/auth/github/handler/frame`
   - Add Client ID/Secret to `.env`

## 🏃‍♂️ Common Operations

### Starting Fresh

```bash
# Stop all services
docker-compose down

# Remove volumes (DELETES ALL DATA!)
docker-compose down --volumes

# Start clean
docker-compose up -d
```

### Updating Configuration

```bash
# After modifying app-config.yaml
docker-compose restart backstage-app

# View configuration changes in logs
docker logs -f backstage-app | grep -i config
```

### Database Management

```bash
# Connect to PostgreSQL
docker exec -it backstage-postgres psql -U backstage -d backstage

# Backup database
docker exec backstage-postgres pg_dump -U backstage backstage > backup.sql

# Restore database
docker exec -i backstage-postgres psql -U backstage -d backstage < backup.sql
```

### Debugging

```bash
# View all container logs
docker-compose logs -f

# Access container shell
docker exec -it backstage-app sh

# Check API health
curl http://localhost:7007/healthcheck

# Test authentication
curl http://localhost:7007/api/auth/github/refresh
```

## 📊 Monitoring & Health

### Health Checks

| Service | Endpoint | Expected Response |
|---------|----------|------------------|
| Frontend | http://localhost:3000 | Backstage UI loads |
| Backend | http://localhost:7007/healthcheck | `{"status":"ok"}` |
| Database | `docker exec backstage-postgres pg_isready` | `accepting connections` |

### Performance Monitoring

```bash
# Resource usage
docker stats

# Response times
curl -w "Total: %{time_total}s\n" -o /dev/null -s http://localhost:7007/api/catalog/entities

# Database performance
docker exec -it backstage-postgres psql -U backstage -d backstage -c "SELECT COUNT(*) FROM entities;"
```

## 🧪 Course Labs

### Lab 1: Basic Setup
- Deploy Backstage with persistent storage
- Configure GitHub authentication
- Import first entities

### Lab 2: Catalog Management  
- Add components and systems
- Configure entity relationships
- Set up auto-discovery

### Lab 3: Templates & Scaffolding
- Create custom templates
- Add template parameters
- Generate new services

### Lab 4: Kubernetes Integration
- Connect to K8s clusters
- View resource status
- Monitor deployments

### Lab 5: Custom Plugins
- Develop frontend plugin
- Create backend plugin
- Add to plugin registry

## 🔧 Troubleshooting

### Common Issues

1. **Entities disappear after restart**
   - **Cause**: Using in-memory database
   - **Solution**: Configure PostgreSQL (already done)

2. **GitHub OAuth not working**
   - **Cause**: Incorrect callback URLs
   - **Solution**: Verify OAuth app settings

3. **Port conflicts**
   - **Cause**: Services already running on ports 3000/7007
   - **Solution**: Stop conflicting services or change ports

4. **Database connection errors**
   - **Cause**: PostgreSQL not ready
   - **Solution**: Wait for health check or restart postgres service

### Debug Scripts

```bash
# Complete environment check
./Docker/debug-environment.sh

# Reset everything (DESTRUCTIVE)
./Docker/reset-environment.sh

# Generate new secrets
./Docker/generate-secrets.sh
```

## 📖 Documentation

Comprehensive course documentation is available at:

- **Course Overview**: [docs/course/index.md](./docs/course/index.md)
- **Architecture Guide**: [docs/course/architecture.md](./docs/course/architecture.md)  
- **Troubleshooting**: [docs/course/troubleshooting.md](./docs/course/troubleshooting.md)

Or access via Backstage TechDocs at: http://localhost:3000/docs

## 🤝 Contributing

This is a training environment. To suggest improvements:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📞 Support

**Course Instructor**: Jaime Henao  
**Email**: jaime.andres.henao.arbelaez@ba.com  
**GitHub**: [@jaime-henao](https://github.com/jaime-henao)

## 📄 License

This course material is for British Airways internal training purposes.

---

**Course Version**: 1.0  
**Last Updated**: August 2024  
**Backstage Version**: 1.33+  
**Maintained by**: DevOps Training Team