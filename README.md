# Great Greeter App

Simple Flask backend + Vue 3 (Vite) frontend demonstrating a greeting API.

Quick start (Docker)
1. From project root:
   ```bash
   docker-compose up --build
   ```
2. Open:
   - Backend: http://localhost:8080
   - Frontend: http://localhost:3002

Project layout
```
great-greeter-app/
├── backend/    # Flask app and Dockerfile
├── frontend/   # Vite + Vue 3 app and Dockerfile
├── infra/   # terraform with multicloud(aws,gcp)
├── scripts/   # scripts
├── docker-compose.yml
└── README.md
```

Note: please set up your env

Local development

Backend (local Python)
```bash
# from repo root
python3 -m pip install --upgrade pip
pip install -r backend/requirements.txt
python backend/app/app.py
# backend: http://localhost:8080
```

Frontend (dev)
```bash
cd frontend
npm install
npm run dev
# Vite dev server: http://localhost:3000
# In dev, frontend proxies /api to the backend (see frontend/vite.config.js)
```

API
- GET /api/        -> greeting (plaintext)
- GET /api/healthz -> JSON health status

Environment
- BACKEND
  - PORT (default 8080)
  - GREETINGS_FILE (path to greetings source)
- FRONTEND
  - VITE_API_URL (used in production or builds)

Notes
- Docker Compose maps host ports; use the Quick start URLs above when running compose.
- The visitor counter is file-backed; it is safe across multiple workers only when the COUNTER_FILE is on a shared filesystem.

Terraform
- cd infra
- terraform init
- terraform validate
- terraform plan
- terraform apply