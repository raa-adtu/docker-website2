Absolutely. For **`my-website2`**, let's do the complete workflow using **VS Code + WSL**, including the important DevOps cycle:

**Create → Build → Run → Modify → Rebuild → Recreate → Run**

We'll use **port 8082**, because your `mynginx` uses 8080 and `my-website1` uses 8081.

---

# Docker Lab 2 — Build and Rebuild a Website with VS Code

## 1. Create the project from VS Code

In your WSL terminal:

```bash
cd ~/Projects
mkdir docker-website2
cd docker-website2
code .
```

VS Code should open the folder:

```text
docker-website2
```

In VS Code's **Explorer**, create these two files:

```text
docker-website2/
│
├── index.html
└── Dockerfile
```

---

# 2. Create `index.html`

In VS Code, right-click the folder → **New File** → `index.html`.

Paste:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>DevOps Student Portal</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            color: #333;
        }

        header {
            background: #1f2937;
            color: white;
            text-align: center;
            padding: 35px;
        }

        header h1 {
            margin-bottom: 10px;
        }

        nav {
            background: #374151;
            text-align: center;
            padding: 15px;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
        }

        .hero {
            background: white;
            text-align: center;
            padding: 70px 20px;
        }

        .hero h2 {
            font-size: 38px;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 19px;
            margin-bottom: 25px;
        }

        .button {
            display: inline-block;
            background: #2563eb;
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        .cards {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            flex: 1;
            min-width: 250px;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .card h3 {
            margin-bottom: 10px;
        }

        footer {
            background: #1f2937;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 50px;
        }
    </style>
</head>

<body>

    <header>
        <h1>DevOps Student Portal</h1>
        <p>Docker Lab - Website 2</p>
    </header>

    <nav>
        <a href="#">Home</a>
        <a href="#courses">Courses</a>
        <a href="#tools">DevOps Tools</a>
        <a href="#contact">Contact</a>
    </nav>

    <section class="hero">
        <h2>Learn DevOps with Docker</h2>
        <p>This website is built with HTML and deployed using Docker.</p>

        <a href="#courses" class="button">Explore Courses</a>
    </section>

    <section class="container" id="courses">

        <h2>Courses</h2>
        <br>

        <div class="cards">

            <div class="card">
                <h3>Git & GitHub</h3>
                <p>
                    Learn version control and collaborate using Git and GitHub.
                </p>
            </div>

            <div class="card">
                <h3>Docker</h3>
                <p>
                    Learn how to build images and run applications inside containers.
                </p>
            </div>

            <div class="card">
                <h3>CI/CD</h3>
                <p>
                    Automate application building, testing and deployment.
                </p>
            </div>

        </div>

    </section>

    <section class="container" id="tools">

        <h2>DevOps Tools</h2>
        <br>

        <div class="cards">

            <div class="card">
                <h3>Git</h3>
                <p>Version control system.</p>
            </div>

            <div class="card">
                <h3>Docker</h3>
                <p>Containerization platform.</p>
            </div>

            <div class="card">
                <h3>Kubernetes</h3>
                <p>Container orchestration platform.</p>
            </div>

        </div>

    </section>

    <section class="container" id="contact">

        <h2>Contact</h2>
        <br>

        <p>Email: student@example.com</p>

    </section>

    <footer>
        <p>&copy; 2026 DevOps Student Portal</p>
    </footer>

</body>
</html>
```

Save:

**Ctrl + S**

---

# 3. Create the Dockerfile in VS Code

Create another file:

```text
Dockerfile
```

Put:

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

Save:

**Ctrl + S**

Your VS Code Explorer should now show:

```text
docker-website2
│
├── Dockerfile
└── index.html
```

---

# 4. Open VS Code Terminal

In VS Code:

**Terminal → New Terminal**

You should get a terminal at:

```text
~/Projects/docker-website2
```

Verify:

```bash
pwd
```

Expected:

```text
/home/dr-rustam/Projects/docker-website2
```

Then:

```bash
ls
```

Expected:

```text
Dockerfile
index.html
```

---

# 5. Build `my-website2`

Run:

```bash
docker build -t my-website2 .
```

The important part is:

```text
docker build
       │
       ├── -t my-website2
       │       ↓
       │   image name
       │
       └── .
           ↓
      current directory
```

Check:

```bash
docker images
```

You should see:

```text
my-website2
my-website1
nginx
hello-world
```

---

# 6. Run `my-website2`

Use port **8082**:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

Check:

```bash
docker ps
```

You should see:

```text
my-website2-container
0.0.0.0:8082->80/tcp
```

---

# 7. Open the website

Open your Windows browser:

```text
http://localhost:8082
```

You should see your **DevOps Student Portal**.

🎉 Your second website is running inside Docker.

---

# 8. Now do the important part — MODIFY

This is where you learn the real Docker development workflow.

Go back to VS Code.

Open:

```text
index.html
```

Find:

```html
<h2>Learn DevOps with Docker</h2>
```

Change it to:

```html
<h2>Welcome to My Docker DevOps Lab!</h2>
```

Also change:

```html
<p>Docker</p>
```

to something like:

```html
<p>Docker Containerization</p>
```

Save:

**Ctrl + S**

---

# 9. Refresh the browser

Go to:

```text
http://localhost:8082
```

You may notice that **your change does NOT appear**.

This is an important Docker concept.

Why?

Because your original `index.html` was copied into the image during:

```bash
docker build
```

The running container has its own copy.

---

# 10. Rebuild the Docker image

Run:

```bash
docker build -t my-website2 .
```

Now the new `index.html` is copied into the newly built image.

But there is another important point:

**Rebuilding the image does not automatically update your existing container.**

Your old container is still using the old image filesystem.

---

# 11. Stop the old container

```bash
docker stop my-website2-container
```

Check:

```bash
docker ps
```

It should no longer be running.

---

# 12. Remove the old container

```bash
docker rm my-website2-container
```

Check:

```bash
docker ps -a
```

The old `my-website2-container` should be gone.

---

# 13. Run the newly rebuilt image

Now:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

Check:

```bash
docker ps
```

Then refresh:

```text
http://localhost:8082
```

🎉 Your modified website should now appear.

---

# The complete development cycle

This is the most important thing for your students to understand:

```text
             VS CODE
                │
                ▼
           index.html
                │
             SAVE
                │
                ▼
       docker build -t my-website2 .
                │
                ▼
        ┌─────────────────┐
        │ Docker Image    │
        │  my-website2    │
        └────────┬────────┘
                 │
             docker run
                 │
                 ▼
        ┌─────────────────┐
        │ Docker Container│
        │ my-website2-    │
        │ container       │
        └────────┬────────┘
                 │
             Port 8082
                 │
                 ▼
          Web Browser
      localhost:8082
```

After modifying:

```text
Modify index.html
       ↓
docker build
       ↓
Stop old container
       ↓
Remove old container
       ↓
Run new container
       ↓
Refresh browser
```

---

## Commands students should remember

### First build

```bash
docker build -t my-website2 .
```

### First run

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

### Check

```bash
docker ps
```

### After modifying HTML

```bash
docker build -t my-website2 .
docker stop my-website2-container
docker rm my-website2-container
docker run -d --name my-website2-container -p 8082:80 my-website2
```

### Browser

```text
http://localhost:8082
```

### One-line concept

> **Code → Dockerfile → Build Image → Run Container → Test → Modify Code → Rebuild Image → Recreate Container → Test Again**

This is an excellent exercise to demonstrate why **Docker images are immutable snapshots** and why changing the source code generally requires creating a new image/container when you're using `COPY` as in this lab.
