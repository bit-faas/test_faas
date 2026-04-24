# 🖥️ Client Application (app)

## 📌 Overview

This folder contains client-side application software that interacts with the deployed FaaS modules remotely.

Applications can be developed in any programming language and communicate with FaaS endpoints over HTTP/HTTPS.

---

## 🎯 Objective

- Provide client applications to consume FaaS services  
- Enable remote invocation of deployed functions  
- Support multi-language integration (Python, Java, JS, etc.)  
- Demonstrate usage patterns for FaaS APIs  

---

## 📂 Folder Structure

The `app/` directory can contain:

```
app/
│
├── <application_code>     → Client application (any language)
├── scripts/               → Optional helper scripts
└── README.md
```

---

## 🔗 FaaS Communication

FaaS modules are exposed via HTTP endpoints.

**Example Endpoint:**
```
https://faas.bitone.in/function/<function-name>
```

---

## 🚀 Usage Example (cURL)

You can invoke a FaaS function using `curl`:

```
curl -X POST https://faas.bitone.in/function/<function-name> \
     -H "Content-Type: application/json" \
     -d '{"key": "value"}'
```

---

## 💻 Multi-Language Support

Applications in this folder can be written in:

- Python  
- Java  
- JavaScript / Node.js  
- C / C++  
- Any language supporting HTTP requests  

---

## 🔁 Integration Flow

1. FaaS module is deployed and available via endpoint  
2. Client application sends HTTP request  
3. FaaS processes the request  
4. Response is returned to the client  

---

## ⚠️ Guidelines

- Do not include server-side FaaS logic in this folder  
- Keep application code independent of FaaS internal structure  
- Use proper error handling for HTTP requests  
- Secure endpoints if required (authentication, headers, etc.)  

---

## 📝 Notes

- This folder is optional and meant for demonstration or integration  
- Applications here simulate real-world usage of deployed FaaS modules  
- Can be extended to mobile apps, desktop tools, or backend services  
