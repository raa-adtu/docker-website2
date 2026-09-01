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



# Add multiple Pages
Yes. You can turn **`my-website2` into a multi-page website** while keeping `my-website1` completely separate.

Your current setup is already good:

```text
my-website1:latest
my-website2:latest
nginx:latest
```

Let's add **Home, About, Courses, and Contact** pages to `my-website2`.

## 1. Your project structure

In VS Code, your folder should become:

```text
docker-website2/
│
├── Dockerfile
│
├── index.html
├── about.html
├── courses.html
└── contact.html
```

All four HTML files will be copied into the Nginx web directory.

---

# 2. Modify your `Dockerfile`

Open `Dockerfile` in VS Code.

Change it to:

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
COPY about.html /usr/share/nginx/html/about.html
COPY courses.html /usr/share/nginx/html/courses.html
COPY contact.html /usr/share/nginx/html/contact.html

EXPOSE 80
```

### What happens during the build?

Docker creates:

```text
my-website2 image
        │
        ▼
/usr/share/nginx/html/
        │
        ├── index.html
        ├── about.html
        ├── courses.html
        └── contact.html
```

---

# 3. Create `about.html`

In VS Code, create:

```text
about.html
```

Put:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - DevOps Student Portal</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f4f6f8;
            color: #333;
        }

        header {
            background: #1f2937;
            color: white;
            padding: 30px;
            text-align: center;
        }

        nav {
            background: #374151;
            padding: 15px;
            text-align: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
        }

        .content {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<header>
    <h1>About Us</h1>
    <p>DevOps Student Portal</p>
</header>

<nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="courses.html">Courses</a>
    <a href="contact.html">Contact</a>
</nav>

<div class="content">

    <h2>About This Website</h2>

    <p>
        This website is created as part of a DevOps and Docker laboratory.
    </p>

    <p>
        The website is developed using HTML and CSS and deployed using
        an Nginx Docker container.
    </p>

    <h3>Technologies Used</h3>

    <ul>
        <li>HTML5</li>
        <li>CSS3</li>
        <li>Docker</li>
        <li>Nginx</li>
        <li>WSL</li>
        <li>Visual Studio Code</li>
    </ul>

</div>

</body>
</html>
```

Save with **Ctrl + S**.

---

# 4. Create `courses.html`

Create:

```text
courses.html
```

Put:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses - DevOps Student Portal</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f4f6f8;
        }

        header {
            background: #1f2937;
            color: white;
            text-align: center;
            padding: 30px;
        }

        nav {
            background: #374151;
            padding: 15px;
            text-align: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 15px;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        .course {
            background: white;
            padding: 25px;
            margin: 20px 0;
            border-radius: 8px;
        }
    </style>
</head>

<body>

<header>
    <h1>Our Courses</h1>
    <p>Learn DevOps Technologies</p>
</header>

<nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="courses.html">Courses</a>
    <a href="contact.html">Contact</a>
</nav>

<div class="container">

    <div class="course">
        <h2>Git & GitHub</h2>
        <p>
            Learn version control, repositories, branches, commits,
            merging and collaboration.
        </p>
    </div>

    <div class="course">
        <h2>Docker</h2>
        <p>
            Learn Docker images, containers, Dockerfiles,
            networking and container deployment.
        </p>
    </div>

    <div class="course">
        <h2>CI/CD</h2>
        <p>
            Learn continuous integration, continuous delivery
            and automated deployment.
        </p>
    </div>

    <div class="course">
        <h2>Kubernetes</h2>
        <p>
            Learn container orchestration, pods, deployments,
            services and scaling.
        </p>
    </div>

</div>

</body>
</html>
```

---

# 5. Create `contact.html`

Create:

```text
contact.html
```

Put:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - DevOps Student Portal</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f4f6f8;
        }

        header {
            background: #1f2937;
            color: white;
            text-align: center;
            padding: 30px;
        }

        nav {
            background: #374151;
            padding: 15px;
            text-align: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 15px;
        }

        .contact {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            box-sizing: border-box;
        }

        button {
            padding: 12px 25px;
            background: #2563eb;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>

<body>

<header>
    <h1>Contact Us</h1>
    <p>DevOps Student Portal</p>
</header>

<nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="courses.html">Courses</a>
    <a href="contact.html">Contact</a>
</nav>

<div class="contact">

    <h2>Send us a message</h2>

    <form>
        <label>Name</label>
        <input type="text" placeholder="Enter your name">

        <label>Email</label>
        <input type="email" placeholder="Enter your email">

        <label>Message</label>
        <textarea rows="5" placeholder="Enter your message"></textarea>

        <button type="submit">Send Message</button>
    </form>

</div>

</body>
</html>
```

Save.

---

# 6. Modify your `index.html` navigation

Your existing `index.html` probably has something like:

```html
<nav>
    <a href="#">Home</a>
    <a href="#courses">Courses</a>
    <a href="#tools">DevOps Tools</a>
    <a href="#contact">Contact</a>
</nav>
```

Replace it with:

```html
<nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="courses.html">Courses</a>
    <a href="contact.html">Contact</a>
</nav>
```

Now the pages are connected.

---

# 7. Build the new image

From your VS Code terminal:

```bash
cd ~/Projects/docker-website2
```

Check:

```bash
ls
```

You should have:

```text
Dockerfile
index.html
about.html
courses.html
contact.html
```

Now build:

```bash
docker build -t my-website2 .
```

You should see:

```text
Successfully tagged my-website2:latest
```

---

# 8. Recreate the container

If your previous `my-website2-container` is running:

```bash
docker stop my-website2-container
docker rm my-website2-container
```

Then run the newly built image:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

Check:

```bash
docker ps
```

You should have something similar to:

```text
mynginx                  → 8080
my-website1-container    → 8081
my-website2-container    → 8082
```

All three can run simultaneously.

---

# 9. Test every page

### Home

```text
http://localhost:8082
```

### About

```text
http://localhost:8082/about.html
```

### Courses

```text
http://localhost:8082/courses.html
```

### Contact

```text
http://localhost:8082/contact.html
```

Click the navigation links to move between pages.

---

# 10. Verify from inside Docker

This is a useful exercise for your students.

```bash
docker exec -it my-website2-container bash
```

Then:

```bash
cd /usr/share/nginx/html
ls -l
```

You should see:

```text
about.html
courses.html
contact.html
index.html
```

This proves that your Dockerfile copied all four pages into the Nginx container.

Exit:

```bash
exit
```

---

## Your final architecture

```text
                         Docker Engine
                              │
            ┌─────────────────┼─────────────────┐
            │                 │                 │
            ▼                 ▼                 ▼
       my-website1       my-website2         mynginx
       Container          Container          Container
          :8081              :8082              :8080
            │                 │
            │                 │
            │          ┌──────┴─────────┐
            │          │                │
            │       index.html      about.html
            │                        courses.html
            │                        contact.html
            │
            ▼                 ▼
      localhost:8081    localhost:8082
```

### The important Docker lesson

When you add pages, you are **not modifying the existing image directly**.

Your workflow is:

```text
VS Code
   ↓
Modify/Create HTML
   ↓
docker build -t my-website2 .
   ↓
New my-website2 image
   ↓
Stop old container
   ↓
Remove old container
   ↓
Create new container
   ↓
Test localhost:8082
```

Your **`my-website1` image and container remain untouched**.
