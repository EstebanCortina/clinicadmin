# Clinicadmin - Fullstack App con Docker Compose

Este proyecto contiene una aplicación fullstack compuesta por:

- **Frontend** (Vue.js)
- **Backend** (Node.js + Express)
- **Base de datos** (PostgreSQL)

Todo está orquestado con **Docker Compose** y separado en submódulos para frontend y backend.

---

## 📦 Requisitos

- Docker
- Docker Compose
- Git

---

## 🚀 Instrucciones para levantar el proyecto

### 1. Clona el repositorio principal con submódulos

```bash
git clone --recurse-submodules https://github.com/EstebanCortina/clinicadmin.git
cd clinicadmin
```

> Si ya lo habías clonado sin `--recurse-submodules`, ejecuta:
>
> ```bash
> git submodule update --init --recursive
> ```

---

### 2. Crea archivo `.env`

Copia el archivo de ejemplo y modifícalo:

```bash
cp .env.example .env
```

> **Nota:** Base de datos y API REST comparten algunas variables.

---

### 3. Verifica el archivo `init.sql`

Asegúrate de que el archivo `init.sql` tenga los comandos SQL necesarios para inicializar la base de datos si deseas precargar datos.

---

### 4. Levanta todos los servicios

```bash
docker-compose up --build
```

Esto construirá y levantará los servicios de:

- PostgreSQL
- Backend
- Frontend

---

### 5. Accede a la aplicación (valores por defecto)

- 🌐 **Frontend:** http://localhost:8080 
- 🛠️ **Backend API:** http://localhost:3000/v1  
- 🐘 **Base de datos:** PostgreSQL accesible en el puerto configurado (por defecto: 5432)

---

## 🔄 Actualizar submódulos

Si haces cambios en los submódulos o quieres actualizarlos:

```bash
git submodule update --remote
```

---

## 🧪 Comprobación rápida

- Puedes probar la API directamente en el navegador o con herramientas como Postman.
- Si necesitas acceder a un contenedor:
  
```bash
docker exec -it clinicadmin-backend sh
```

---

## 🧹 Apagar y limpiar

Para detener los servicios:

```bash
docker-compose down
```

Para borrar volúmenes y datos persistentes (⚠️ esto elimina tu base de datos):

```bash
docker-compose down -v
```

---
