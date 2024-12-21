
## Introduction/Research

I will be documenting my research in the following assignment.

### About bWAPP 
bWAPP, or a buggy web application, is a free and open-source web application designed to help security enthusiasts, developers, and students to discover and prevent web vulnerabilities. It prepares one to conduct successful penetration testing and ethical hacking projects. It is a **PHP application** that uses a **MySQL** database. It can be hosted on **Linux**, Windows, and Mac with the help of a **web server**.

#### Key Takeways for us
- bWAPP is PHP Based Application
- It uses MySQL Database
- It can be hosted on Linux
- It's [Github](https://github.com/lmoroz/bWAPP) shows it can be hosted on Apache Server 


## Milestone 1: Setting up bWAPP on Docker 

I already have some understanding of Docker and have used it in the past but this bWAPP requires older stack that i have not used before.

From our understanding bWAPP requires PHP, MySQL, Linux and Apache Server.

Now, We have 2 options to setup bWAPP:
 1. **Simple Way**: With simple google search we can see that there are already docker images available for bWAPP. It uses some older LAMP stack. and we can use it to setup bWAPP.

 2. **Good Way/Hard Way**: 
    - We can setup our own LAMP stack and then install bWAPP on it. This will give us more control and understanding of the setup.
    
    - This Will Also allow me to show my understanding of assignment.


### Setting up DockerFile 

Github Repo provided shows it can support PHP7. This gives us major advantage as we can use latest supported PHP version but if we gone with docker images already there such us tutum-docker-lamp we would have to use older PHP version.

I will be using PHP7.4 and Ubuntu 18.04 for my setup.
> I will be using Ubuntu 18.04 because this project is realtively very old using latest Ubuntu might cause some issues. 

With Some simple modifications to DockerFile we are ready to use bWAPP.

### Installation Steps

1. **Build Docker Image**: 
    - `docker build -t assignment-submission-bwapp`

2. **Run Docker Image**:
    - `docker run -it -p 80:80 assignment-submission-bwapp`


### Verifying SSRF Vulnerability

Although, I am Completly new to Cyber Security and Ethical Hacking. I have tried to understand the concept of SSRF and how it can be exploited.

Here I successfully exploited the SSRF vulnerability in bWAPP. (this link if you want to reproduce it)

``
http://127.0.0.1/rlfi.php?language=evil/ssrf-1.txt&action=go&ip=127.0.0.1
``



## Milestone 2: Adding Firewall in our Docker Container

I will be using WAF (Web Application Firewall) to protect our bWAPP from SSRF Vulnerability. with my research i found that ModSecurity is a good WAF and it can be used with Apache Server.

With Some basic configurations we can setup ModSecurity in our Docker Container.

I have created 2 DockerFiles for this. One with ModSecurity and one without ModSecurity.

### Installation Steps

1. **Run Docker Image**:
    - `docker run -it -p 80:80 assignment-submission-bwapp`

2. **Edit the ModSecurity configuration**
    - `nano /etc/modsecurity/modsecurity.conf`

3. **SecRuleEngine**
    - On

4. **Restart Apache Server**
    - `service apache2 restart`

5. **Custom Firewall Rule to block attack**
    - `nano /etc/apache2/sites-available/000-default.conf`

```
SecRule REQUEST_URI "@rx /rlfi.php\?language=https:\/\/.*&action=go&ip=" \
    "chain,id:1001,deny,status:403,msg:'SSRF detected - Direct access to external resources not allowed'"
    SecRule ARGS:ip "@contains 127.0.0.1" "t:none" 
```
