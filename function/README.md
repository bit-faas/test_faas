# 📂 Source Module (src)

## 📌 Overview

This folder contains the core implementation of the FaaS function, including handler logic, tests, dependencies, and supporting modules.

---

## 🎯 Objective

- Define the function logic (`handler.py`)  
- Provide unit testing (`handler_test.py`)  
- Manage Python dependencies (`requirements.txt`)  
- Support modular code organization within `src/`  

---

## 📂 Folder Structure

The `src/` directory should follow this structure:

```
src/
│
├── handler.py           → Main FaaS handler
├── handler_test.py      → Unit tests for handler
├── requirements.txt     → Python dependencies (pip install)
│
├── <supporting_files>   → Additional modules / utilities
└── <subfolders>/        → Optional submodules
```

---

## 🧩 Core Files

### handler.py
- Entry point of the FaaS function  
- Contains the main logic executed during invocation under the function:handle(arg) 

### handler_test.py
- Contains unit tests for the handler  
- Executed during CI pipeline  

### requirements.txt
- List of Python dependencies  
- Installed during Docker image build using `pip install`  

---

## 📦 Supporting Files

- Additional Python modules and helper files can be placed inside `src/`  
- Subfolders are also supported for better modularization  

### Important Note

Since these files are **not added to PYTHONPATH during Docker build**,  
they must be imported using relative-style module references.

**Example:**
```python
from .module_name import some_function
```
or (based on structure)
```python
from module_name import some_function
```

---

## 🔗 Dependency Integration (deps.gradle)

- External dependencies can be managed using `deps.gradle`  
- This script is invoked from `build.gradle`  

### Build Behavior

- During build, all files from `src/` are copied into a runtime folder named:

```
function/
```

- Files downloaded via `deps.gradle` are also placed inside this `function/` folder  

---

## ⚠️ Guidelines

- Always include:
  - `handler.py`
  - `handler_test.py`
  - `requirements.txt`  
- Keep all supporting modules inside `src/`  
- Ensure imports work without modifying PYTHONPATH  
- Maintain compatibility with build process (files will be moved to `function/`)  

---

## 📝 Notes

- `src/` acts as the **development workspace**  
- `function/` is the **runtime build output**  
- Any structure inside `src/` should work after being moved to `function/`  
