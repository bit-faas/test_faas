# 📦 FaaS Template Repository

## 📌 Overview

This repository provides a standardized template for building and deploying FaaS modules using OpenFaaS with automated CI/CD support.

It ensures consistent structure, automated validation, and seamless deployment across environments.

---

## 🎯 Objective

- Ensure all FaaS modules follow a consistent structure  
- Enable automatic testing before merge  
- Support deployment across client machines  
- Simplify scalability and management  

---

## 📂 Repository Structure

This template follows a standardized structure:

```
faas-template/
│
├── build.gradle        → Gradle tasks (build-faas, push-faas, deploy-faas)
├── function.yml        → OpenFaaS configuration
├── deps.gradle         → External dependencies
│
├── src/                → Source code (developer working directory)
│   ├── handler.py
│   ├── handler_test.py
│
├── app/                → Client application using this FaaS module
│
└── README.md
```

**Notes:**
- `src/` contains core function logic  
- `app/` contains client applications invoking the FaaS  
- `deps.gradle` manages external dependencies  

---

## 🛠️ Build Behavior

- A `build/` folder is created during runtime  
- This folder is temporary and used only for build execution  
- It must not be committed to the repository  

**.gitignore requirement:**
```
build/
```

---

## 🔄 Development Flow (CI – Test Server)

1. Developer pushes to `dev` / feature branch  
2. Pull Request created → `main`  
3. Jenkins Test Server is triggered  
4. Build and test execution  
5. On success → reviewer approval  
6. Merge to `main`  

**CI Responsibilities:**
- Build FaaS module  
- Execute unit tests (`handler_test.py`)  
- Validate functionality before merge  

---

## 🚀 Production Flow (CD – Production Server)

1. Code merged to `main`  
2. Production Jenkins triggered  
3. Clean build execution  
4. Test verification  
5. Docker image creation  
6. Push image to registry  

---

## 📦 Deployment Model

- Docker images are published to a central registry  
- Client systems can:
  - Pull the image  
  - Import into container runtime  
  - Deploy using OpenFaaS  

---

## 🔁 Client Usage

Any client machine with:

- Docker  
- OpenFaaS (faasd)  

Can:

- Pull → Deploy → Invoke function  

This supports:

- Remote execution  
- Multi-device usage (server, desktop, mobile)  

---

## 🧪 Testing Strategy

- Test file location: `src/handler_test.py`  

**Standard test function:**
```python
def test_handle():
```

**Notes:**
- Default test is included  
- Developers should extend test cases  
- Tests run automatically during CI  

---

## 🔗 CI/CD Integration

Integrated with Jenkins pipelines:

**Test Pipeline**
- Trigger: PR to main  
- Purpose: validation  

**Production Pipeline**
- Trigger: main branch update  
- Purpose: build and publish  

---

## ⚠️ Guidelines

- Do not modify folder structure  
- Do not commit build artifacts  
- Ensure handler matches `function.yml`  
- Always maintain/update `handler_test.py`  

---

## 🚀 Future Enhancements

- Version-based deployments  
- Multi-function support  
- Centralized dependency management  
- Automated client updates  

---

## 📝 Notes

This template is designed to:

- Standardize FaaS development  
- Reduce manual deployment effort  
- Enable scalable distributed execution  